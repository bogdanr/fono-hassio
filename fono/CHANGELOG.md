# Changelog

## 0.14.0

- Track Fono 0.14.0 and pin the base image to the release tag
  (`ghcr.io/bogdanr/fono:v0.14.0`) instead of `:latest`.
- Add the add-on icon and logo.

## 0.11.0

- Initial release. Home Assistant add-on wrapping the Fono Wyoming server
  image (`ghcr.io/bogdanr/fono`): local speech-to-text and text-to-speech on
  port 10300, with options for languages, models, local/cloud backends, and
  voices. GPU acceleration is CPU-fallback only in this release.
