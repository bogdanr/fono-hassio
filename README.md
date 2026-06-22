# Fono — Home Assistant Add-ons

Home Assistant add-on for [**Fono**](https://github.com/bogdanr/fono):
local-first **speech-to-text and text-to-speech** over the
[Wyoming protocol](https://www.home-assistant.io/integrations/wyoming/),
with optional Vulkan GPU acceleration.

This repository wraps the prebuilt, multi-arch Fono server image
(`ghcr.io/bogdanr/fono`) as a one-click Supervisor add-on. It does **not**
recompile Fono — it reuses the published image and only translates the
add-on options form into Fono's configuration.

> **Add-ons require Home Assistant OS or a Supervised install.** On Home
> Assistant Core or a plain Docker setup, run the container directly and add
> it via the built-in **Wyoming Protocol** integration instead — see the
> [Fono Home Assistant guide](https://github.com/bogdanr/fono/blob/main/docs/home-assistant.md).

## Install

1. In Home Assistant: **Settings → Add-ons → Add-on Store**.
2. Open the **⋮** menu (top right) → **Repositories**.
3. Add: `https://github.com/bogdanr/fono-hassio`
4. Install the **Fono** add-on, then **Start** it.
5. Add the **Wyoming Protocol** integration pointing at the add-on host on
   port `10300`, and select Fono for speech-to-text and/or text-to-speech in
   your Assist pipeline.

[![Add repository to your Home Assistant instance.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbogdanr%2Ffono-hassio)

## Add-ons in this repository

- **[Fono](fono/)** — Wyoming STT/TTS server. See its
  [documentation](fono/DOCS.md).

## License

GPL-3.0-only, matching upstream Fono. See [LICENSE](LICENSE).
