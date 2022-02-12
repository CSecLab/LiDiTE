FROM debian:10

RUN apt-get update && apt-get install -y git
WORKDIR /usr/local/src
RUN git clone https://github.com/thiagoralves/OpenPLC_v3.git
WORKDIR /usr/local/src/OpenPLC_v3
RUN ./install.sh docker
COPY ./entrypoint.sh ./
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
