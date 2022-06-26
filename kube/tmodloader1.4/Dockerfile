FROM steamcmd/steamcmd:ubuntu-20

LABEL maintainer="kumori@ryougi.com"

RUN apt-get update && \
    apt-get -y install --no-install-recommends wget unzip curl libicu-dev && \
    rm -rf /var/lib/apt/lists/*

ENV DATA_DIR=/serverdata
ENV SERV_VER=1423
ENV TMOD_VER=v2022.05.103.34

RUN mkdir /terrariadata && \
    mkdir ${DATA_DIR}

WORKDIR /terrariadata

RUN wget --no-check-certificate https://terraria.org/api/download/pc-dedicated-server/terraria-server-${SERV_VER}.zip && \
    unzip terraria-server-${SERV_VER}.zip -d Terraria && \
    rm terraria-server-${SERV_VER}.zip

RUN wget --no-check-certificate https://github.com/tModLoader/tModLoader/releases/download/${TMOD_VER}/tModLoader.zip && \
    unzip tModLoader.zip -d tModLoader && \
    rm tModLoader.zip 

RUN chmod +x tModLoader/start-tModLoader.sh
RUN chmod +x tModLoader/LaunchUtils/*.sh

WORKDIR /terrariadata/tModLoader

COPY docker-entrypoint.sh docker-entrypoint.sh
ENTRYPOINT "./docker-entrypoint.sh"
