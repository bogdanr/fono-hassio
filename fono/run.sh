#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-only
#
# Home Assistant add-on shim for Fono.
#
# Supervisor writes the add-on options to /data/options.json. This script
# translates them into the FONO_* environment contract that the base image's
# entrypoint (/usr/local/bin/fono-entrypoint) already understands, then hands
# off to it. The base image is `FROM scratch` with busybox only — no bashio,
# no jq — so option parsing is done with portable POSIX sed.
#
# options.json is a flat object (one key per line) and our values never
# contain embedded double quotes, so a quote-delimited capture is sufficient.
set -eu

OPTIONS=/data/options.json

# Print the string value for a flat JSON key, or nothing if absent/empty.
json_str() {
    [ -f "$OPTIONS" ] || return 0
    sed -n 's/.*"'"$1"'"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$OPTIONS" | head -n1
}

# Print a bareword value (numbers, booleans) for a flat JSON key.
json_word() {
    [ -f "$OPTIONS" ] || return 0
    sed -n 's/.*"'"$1"'"[[:space:]]*:[[:space:]]*\([A-Za-z0-9._-]*\).*/\1/p' "$OPTIONS" | head -n1
}

# export NAME=VALUE only when VALUE is non-empty.
set_env() {
    if [ -n "${2:-}" ]; then
        export "$1=$2"
    fi
}

set_env FONO_LANGUAGES       "$(json_str languages)"
set_env FONO_STT_BACKEND     "$(json_str stt_backend)"
set_env FONO_STT_MODEL       "$(json_str stt_model)"
set_env FONO_TTS_BACKEND     "$(json_str tts_backend)"
set_env FONO_TTS_LOCAL_VOICE "$(json_str tts_local_voice)"
set_env FONO_MDNS_NAME       "$(json_str mdns_name)"
set_env FONO_WYOMING_PORT    "$(json_word wyoming_port)"

# Cloud API keys: each is exported only when the user filled it in, so an
# empty form leaves Fono on its fully-local default backends.
for pair in \
    groq_api_key:GROQ_API_KEY \
    openai_api_key:OPENAI_API_KEY \
    deepgram_api_key:DEEPGRAM_API_KEY \
    gemini_api_key:GEMINI_API_KEY \
    elevenlabs_api_key:ELEVENLABS_API_KEY \
    cartesia_api_key:CARTESIA_API_KEY \
    speechmatics_api_key:SPEECHMATICS_API_KEY \
    openrouter_api_key:OPENROUTER_API_KEY; do
    opt=${pair%%:*}
    var=${pair##*:}
    set_env "$var" "$(json_str "$opt")"
done

# Regenerate config from these options on every (re)start, and keep the
# listener reachable on the add-on network (not a user-facing option).
export FONO_CONTAINER_WRITE_CONFIG=always
export FONO_WYOMING_BIND=0.0.0.0

exec /usr/local/bin/fono-entrypoint fono
