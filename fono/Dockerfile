# syntax=docker/dockerfile:1
# Thin Home Assistant add-on wrapper over the prebuilt Fono server image.
# It adds only the options shim; the Vulkan runtime, certs, busybox and the
# Fono binary all come from the base image, preserving its exact glibc/Vulkan
# stack.
ARG BUILD_FROM
FROM ${BUILD_FROM}

# The base image's busybox shell + utilities are installed under /bin.
COPY run.sh /usr/local/bin/fono-hassio-run
RUN ["/bin/busybox", "chmod", "0755", "/usr/local/bin/fono-hassio-run"]

# Run the add-on shim instead of the base entrypoint. The shim reads the
# Supervisor options, exports the matching FONO_* env, then execs the base
# image's own entrypoint (/usr/local/bin/fono-entrypoint).
ENTRYPOINT []
CMD ["/usr/local/bin/fono-hassio-run"]
