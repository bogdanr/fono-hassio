#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-only
# Start Fono inside Home Assistant. Fono's own settings, edited in its
# sidebar panel, are the single source of truth: they are written once on
# first start and never overwritten. The one app option, a cloud API key,
# is applied only when it changes.
set -eu

export FONO_SERVICES=asr,tts,wake,handle
export FONO_WEB_ENABLED=true FONO_WEB_TRUSTED_PROXY=172.30.32.2
export FONO_WYOMING_BIND=0.0.0.0 FONO_MDNS_NAME=Fono
# The HTTP API on 11434. Other devices need a key created in the panel.
export FONO_LLM_ENABLED=true
# Home Assistant's MCP server, reached through the Supervisor, which also
# provides the token. The token stays in the environment, never on disk.
export HOME_ASSISTANT_TOKEN="${SUPERVISOR_TOKEN:-}"
mcp_url=http://supervisor/core/api/mcp

ha_api() { # ha_api <path> [json body]
    if [ $# -gt 1 ]; then
        wget -q -O - --header "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
            --header "Content-Type: application/json" --post-data "$2" \
            "http://supervisor/core/api/$1"
    else
        wget -q -O - --header "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
            "http://supervisor/core/api/$1"
    fi
}

# Home control needs Home Assistant's Model Context Protocol Server
# integration. Set it up with the Assist API when it isn't there yet.
if ! ha_api "config/config_entries/entry?domain=mcp_server" 2>/dev/null | grep -q '"entry_id"'; then
    flow=$(ha_api config/config_entries/flow '{"handler":"mcp_server"}' 2>/dev/null \
        | sed -n 's/.*"flow_id" *: *"\([^"]*\)".*/\1/p')
    if [ -n "$flow" ] && ha_api "config/config_entries/flow/$flow" '{"llm_hass_api":["assist"]}' \
        >/dev/null 2>&1; then
        echo "[fono] set up Home Assistant's Model Context Protocol Server for home control"
    else
        echo "[fono] could not set up the Model Context Protocol Server; add it under" \
            "Settings > Devices & services to let Fono control devices"
    fi
fi

key=$(tr -d '\n' < /data/options.json | sed -n 's/.*"api_key" *: *"\([^"]*\)".*/\1/p')
langs=$(tr -d '\n' < /data/options.json | sed -n 's/.*"languages" *: *"\([^"]*\)".*/\1/p')
stamp=/data/.applied_key
sum=$(printf '%s' "$key" | sha256sum | cut -d' ' -f1)

announce() {
    i=0
    until printf '' | nc -w 1 127.0.0.1 10300 2>/dev/null; do
        i=$((i + 1)); [ "$i" -gt 600 ] && return 0; sleep 1
    done
    wget -q -O /dev/null --header "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
        --header "Content-Type: application/json" \
        --post-data "{\"service\":\"wyoming\",\"config\":{\"uri\":\"tcp://$(hostname):10300\"}}" \
        http://supervisor/discovery && echo "[fono] offered to Home Assistant as tcp://$(hostname):10300"
}
announce &

# The entrypoint writes Fono's first config, then runs this script's tail:
# apply a changed API key, connect home control once, set the languages
# (from the option when it changes, else from Home Assistant once), start
# Fono.
exec /usr/local/bin/fono-entrypoint sh -c '
    if [ -n "$0" ] && [ "$(cat "$2" 2>/dev/null)" != "$1" ]; then
        printf "%s\n" "$0" | fono keys connect && printf "%s" "$1" > "$2"
    fi
    if [ ! -f /data/.home_control ]; then
        fono config home-assistant "$3" && touch /data/.home_control
    fi
    if [ -n "$4" ]; then
        if [ "$(cat /data/.applied_languages 2>/dev/null)" != "$4" ]; then
            fono config languages "$4" && printf "%s" "$4" > /data/.applied_languages
        fi
    elif [ ! -f /data/.languages_from_home_assistant ]; then
        fono config languages --from-home-assistant ws://supervisor/core/websocket \
            && touch /data/.languages_from_home_assistant
    fi
    exec fono' "$key" "$sum" "$stamp" "$mcp_url" "$langs"
