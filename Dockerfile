FROM debian:stretch

ENV MINECRAFT_JAR minecraft_server.1.15.2.jar

RUN apt update \
    && apt install -y default-jre ca-certificates-java curl \
    && curl -sL https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar -o /${MINECRAFT_JAR}

WORKDIR /data
VOLUME /data

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

#Automatically accept Minecraft EULA, and start Minecraft server
CMD echo eula=true > /data/eula.txt \
    && java -Xmx1024M -Xms1024M -jar /${MINECRAFT_JAR} nogui
