FROM alpine:3
RUN apk add --no-cache socat
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint
ENTRYPOINT [ "/entrypoint" ]
