# Compile
FROM registry.fedoraproject.org/fedora-minimal:36 AS build
RUN microdnf install -y \
  binutils \
  musl-gcc \
  && microdnf clean all
WORKDIR /usr/local/src
COPY nothing.c /usr/local/src/nothing.c
RUN \
  musl-gcc -static -o /usr/local/bin/nothing -Os -flto -fwhole-program nothing.c \
  && strip --strip-all /usr/local/bin/nothing \
  && chmod +x /usr/local/bin/nothing \
  && ls -l /usr/local/bin/nothing
# Scratch
FROM scratch
COPY --from=build /usr/local/bin/nothing /nothing
CMD [ "/nothing" ]
