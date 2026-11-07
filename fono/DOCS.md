# Fono

Fono gives Home Assistant a voice: listening, speaking, a wake word, and a
voice assistant that can control your home. Use all of it, or only the
parts you want.

## Getting started

1. Start the app.
2. Home Assistant finds Fono on its own. Go to **Settings → Devices &
   services** and click **Add** on the Fono card.
3. In **Settings → Voice assistants**, open a voice assistant and choose
   Fono for speech-to-text, text-to-speech, the conversation agent, or all
   three.

## Cloud or local

Out of the box, everything runs on your machine. Nothing leaves your
network.

If you'd rather use a cloud service, for faster answers or better voices,
add its API key in the **Fono** panel in the sidebar. You can also paste it
under **Configuration**. Fono works out which provider the key belongs to
and sets itself up to use it. Groq and Gemini both have free plans.

Keys you've added aren't shown under **Configuration**; that field is only
for adding a new one. You'll find all your keys in the Fono panel.

## Languages

On first start, Fono asks Home Assistant which languages your voice
assistants use, and uses those. To choose them yourself, fill in
**Languages** under **Configuration** (for example `ro, en`, the one you use
most first), or change them in the Fono panel.

## Controlling your home

The voice assistant can control the devices you've shared with Assist
(**Settings → Voice assistants → Expose**). It can't see or touch anything
else.

To make this work, Fono sets up Home Assistant's **Model Context Protocol
Server** integration on first start, if you don't have it already. You
don't need to do anything.

If a voice assistant has **Prefer handling commands locally** turned on,
Home Assistant handles simple commands like "turn on the kitchen light"
itself, and passes everything else to Fono.

## Using Fono from other devices

Port 11434 offers an OpenAI- and Ollama-compatible API for chat,
transcription and speech, so other apps on your network can use Fono too.
They need an API key, which you create in the Fono panel. Without one,
they're turned away.
