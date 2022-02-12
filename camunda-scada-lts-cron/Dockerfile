FROM debian:10.9
RUN apt-get update -qq && apt-get install -y curl wait-for-it
COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
