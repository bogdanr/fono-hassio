# Fono

Local-first **speech-to-text and text-to-speech** for Home Assistant, served
over the [Wyoming protocol](https://www.home-assistant.io/integrations/wyoming/).
Fono runs entirely on your machine by default — audio and transcripts never
leave the box unless you opt into a cloud backend.

This add-on wraps the prebuilt, multi-arch Fono server image
(`ghcr.io/bogdanr/fono`); it does not recompile anything.

## Installation

1. Install and **Start** the add-on.
2. On first start it downloads the chosen Whisper model and a Piper voice into
   the add-on's persistent storage. This can take a few minutes and a few
   hundred MB — it only happens once.
3. Add the **Wyoming Protocol** integration
   (**Settings → Devices & Services → Add Integration → Wyoming Protocol**),
   pointing at this host on port `10300`.
4. In **Settings → Voice assistants**, select **Fono** for **Speech-to-text**
   and/or **Text-to-speech** in your Assist pipeline.

## What you get by default

| Service | Default |
| --- | --- |
| Speech-to-text | local Whisper `small` |
| Text-to-speech | local Piper |
| Languages | `en` |
| Port | `10300` (Wyoming) |

No API keys or internet access are required for the defaults.

## Options

| Option | Purpose |
| --- | --- |
| `languages` | Recognised languages, comma-separated (e.g. `en,ro`). |
| `stt_backend` | `local`, or a cloud provider (needs its API key). |
| `stt_model` | Local Whisper model: `small`, `large-v3-turbo`, `tiny`, … |
| `tts_backend` | `local` Piper, a cloud provider, or `none` to disable TTS. |
| `tts_local_voice` | Optional Piper voice, e.g. `en_US-amy-medium`. |
| `mdns_name` | Service name advertised on the network. |
| `wyoming_port` | Wyoming TCP port (default `10300`). |
| `*_api_key` | Cloud provider keys; only needed for the matching backend. |

Changing an option and restarting regenerates Fono's configuration
automatically.

## GPU acceleration

The image is Vulkan-capable but runs on the **CPU by default**, which works on
every host. GPU acceleration needs the host render node (`/dev/dri`) mapped
into the add-on, which is not enabled in this version because a missing device
would stop the add-on from starting on GPU-less hosts. A dedicated GPU variant
is planned — until then, GPU users can run the
[container directly](https://github.com/bogdanr/fono/blob/main/docs/home-assistant.md)
with `/dev/dri` mapped.

NVIDIA acceleration is not available on Home Assistant OS (it lacks the NVIDIA
Container Toolkit); use the container on a host you control for NVIDIA GPUs.

## Storage and backups

Models, cache, and the generated configuration live in the add-on's `/data`
volume and persist across restarts and updates. Home Assistant includes `/data`
in add-on backups.

## Privacy

With the default `local` backends, all speech processing stays on this
machine. Cloud backends are strictly opt-in and only active when you select
one and provide its API key.
