FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates curl wget tar unzip jq xvfb xauth procps gosu \
        wine wine32 wine64 winbind cabextract \
        lib32gcc-s1 lib32stdc++6 zlib1g:i386 && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/steam /opt/games/server /opt/games/config /opt/wine && \
    useradd -m -u 1000 -s /bin/bash gsh && \
    chown -R gsh:gsh /opt/steam /opt/games /opt/wine

USER gsh
WORKDIR /opt/steam

RUN wget -q https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz

USER root

COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

ENV GSH_STEAM_APP_ID=4129620
ENV GSH_GAME_UPDATE=true
ENV GSH_SERVER_NAME="GSH Windrose Server"
ENV GSH_MAX_PLAYERS=4
ENV GSH_GAME_PORT=7777

WORKDIR /opt/games/server

EXPOSE 7777/udp
EXPOSE 7777/tcp

ENTRYPOINT ["/scripts/entrypoint.sh"]
