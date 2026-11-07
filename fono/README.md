# Fono

Fono gives Home Assistant a voice. It listens, it talks back, it wakes up
when you call it, and it can run your home by voice, all from one app.

You can use all of it, or only the parts you want. One app does the job of
Whisper, Piper and openWakeWord.

## What you get

- **Listening.** Speech is turned into text right here on your machine, or by
  a cloud service such as Groq, OpenAI or Gemini if you'd rather.
- **Speaking.** 48 built-in voices that run on your machine, or the voices of
  your cloud provider.
- **A wake word**, heard by Fono on this machine, so your satellites don't
  need to listen for it themselves.
- **A voice assistant that does things.** Ask it a question, or to turn off
  the lights in the basement. It sees the devices you've shared with Assist,
  and nothing else.

## Getting started

1. Start the app.
2. Home Assistant finds Fono on its own. Go to **Settings → Devices &
   services** and click **Add** on the Fono card.
3. In **Settings → Voice assistants**, choose Fono for the parts you want.

That's all. Fono works without any cloud account. If you have an API key
from a cloud provider, add it in the **Fono** panel in the sidebar, and
Fono sets itself up to use it.

The Fono panel is also where you try out voices, pick languages and models,
and look at past conversations.
