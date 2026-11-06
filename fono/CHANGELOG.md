# Changelog

## 0.20.0

- Two options: a cloud API key and the languages. Fono recognises the provider and uses
  it for speech, voice and the conversation agent. Everything else moved to
  the Fono panel in the sidebar.
- Home Assistant discovers Fono, and Fono offers itself as a conversation
  agent.
- Home control: on first start the app sets up Home Assistant's Model
  Context Protocol Server integration and connects the assistant to it.
  (#1)
- Port 11434 serves Fono's OpenAI- and Ollama-compatible API. Other devices
  need a key created in the panel. (#2)
- Fono takes its languages from Home Assistant on first start: the
  preferred voice assistant's, Home Assistant's own, the other voice
  assistants', then English. A **Languages** option sets them by hand. (#3)

## 0.14.0

- Track Fono 0.14.0 and pin the base image to the release tag
  (`ghcr.io/bogdanr/fono:v0.14.0`) instead of `:latest`.
- Add the add-on icon and logo.

## 0.11.0

- Initial release. Home Assistant add-on wrapping the Fono Wyoming server
  image (`ghcr.io/bogdanr/fono`): local speech-to-text and text-to-speech on
  port 10300, with options for languages, models, local/cloud backends, and
  voices. GPU acceleration is CPU-fallback only in this release.
