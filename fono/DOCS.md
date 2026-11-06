# Fono

One app for every part of a Home Assistant voice assistant:

- **Speech-to-text**, local (Whisper) or cloud (Groq, OpenAI, Deepgram, Gemini, ElevenLabs and more)
- **Text-to-speech**, local (Supertonic, 48 voices) or cloud
- **Wake word**, detected on the server
- **Conversation agent**, answered by the cloud model of your choice, that
  can control your devices

It replaces Whisper, Piper and openWakeWord, and can stand in for the
conversation agent too. Use all of it or only the parts you want.

## Setup

1. **Start** the app.
2. Under **Settings → Devices & services**, click **Add** on the
   discovered **Fono** card.
3. Under **Settings → Voice assistants**, pick Fono for the parts you want.

Everything runs locally by default. To use a cloud provider, paste its API
key in the **Fono** panel in the sidebar, or under **Configuration**. Fono
recognises the provider from the key.

Fono takes its languages from Home Assistant on first start: the
preferred voice assistant's language, Home Assistant's own, the other voice
assistants', then English. To choose them yourself, fill in **Languages**
under **Configuration**, for example `ro, en`.

## Home control

The conversation agent controls the devices you expose to Assist
(**Settings → Voice assistants → Expose**). On first start Fono sets up
Home Assistant's **Model Context Protocol Server** integration for this,
if it isn't set up already.

With **Prefer handling commands locally** turned on in a voice assistant,
Home Assistant handles simple commands such as "turn on the kitchen light"
itself, and Fono answers everything else.

## Other devices

Port 11434 serves an OpenAI- and Ollama-compatible API for chat,
transcription and speech. Other devices need an API key, created in the
**Fono** panel.

## Settings

Open **Fono** in the sidebar for voices with previews, languages, models,
the assistant, history and system health.

## Requirements

Local speech-to-text needs a CPU with AVX2: Intel from 2013 (Haswell) or
AMD from 2015 on, and Intel N100 and newer. On CPUs without it, such as
older Atom, Celeron and Pentium chips, Fono turns local speech-to-text off
and tells you so; add a cloud key to use it there.
Text-to-speech, the wake word and the conversation agent work on any CPU.
