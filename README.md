# Fono for Home Assistant

The Home Assistant app for [**Fono**](https://github.com/bogdanr/fono):
speech-to-text, text-to-speech, a wake word and a voice assistant that can
control your home, in one app.

The app runs the published Fono image (`ghcr.io/bogdanr/fono`), so it's
always the same Fono as everywhere else.

> **Apps need Home Assistant OS or a Supervised install.** With Home
> Assistant Container or Core, run the Fono container yourself and add it
> with the **Wyoming Protocol** integration. See the
> [Fono Home Assistant guide](https://github.com/bogdanr/fono/blob/main/docs/home-assistant.md).

## Install

1. In Home Assistant, go to **Settings → Apps → App store**.
2. Open the **⋮** menu (top right) → **Repositories**, and add
   `https://github.com/bogdanr/fono-hassio`. Or click the button below.
3. Install **Fono** and start it.
4. Home Assistant finds Fono on its own: click **Add** on the Fono card under
   **Settings → Devices & services**.

[![Add repository to your Home Assistant instance.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbogdanr%2Ffono-hassio)

## Apps in this repository

- **[Fono](fono/)**. See its [documentation](fono/DOCS.md).

## License

GPL-3.0-only, matching upstream Fono. See [LICENSE](LICENSE).
