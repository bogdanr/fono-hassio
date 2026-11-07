# The Fono app image: Fono's release binary plus the few files it needs to
# run, about 14 MB to download. Fono links only libc, libm, libgcc_s and the
# dynamic linker, so that is all the C library this image carries.
#
# The release workflow puts `fono-amd64` / `fono-arm64` (from the matching
# Fono release, checksum-verified) and Fono's container `entrypoint.sh` next
# to this file before building.
FROM debian:trixie-slim AS libs
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        busybox-static ca-certificates \
    && t="$(uname -m)-linux-gnu" \
    && mkdir -p /r/bin /r/etc/ssl /r/usr/lib/$t /r/tmp \
    && cp /bin/busybox /r/bin/busybox \
    && cp -a /etc/ssl/certs /r/etc/ssl/certs \
    && cp -a /usr/lib/$t/libc.so.6 /usr/lib/$t/libm.so.6 /usr/lib/$t/libgcc_s.so.1 \
        /usr/lib/$t/ld-linux-*.so.* /r/usr/lib/$t/ \
    && if [ -d /usr/lib64 ]; then cp -a /usr/lib64 /r/usr/lib64; fi \
    && for l in /usr/lib/ld-linux-*; do if [ -e "$l" ]; then cp -a "$l" /r/usr/lib/; fi; done \
    && chmod 1777 /r/tmp

FROM scratch
ARG TARGETARCH
COPY --from=libs /r/ /
# COPY keeps the executable bit the files have in the build context.
COPY fono-${TARGETARCH} /usr/local/bin/fono
COPY entrypoint.sh /usr/local/bin/fono-entrypoint
COPY run.sh /usr/local/bin/fono-hassio-run
RUN ["/bin/busybox", "--install", "-s", "/bin"]
RUN ["/bin/busybox", "ln", "-s", "usr/lib", "/lib"]
RUN ["/bin/busybox", "sh", "-c", "if [ -d /usr/lib64 ]; then ln -s usr/lib64 /lib64; fi"]
# Fails the build if the binary can't load.
RUN ["/usr/local/bin/fono", "--version"]
ENV HOME=/data FONO_LOG=info
WORKDIR /data
CMD ["/usr/local/bin/fono-hassio-run"]
