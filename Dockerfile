FROM debian:stretch

ENV VERSION 1.15.2
ENV BUILD 350
ENV MINECRAFT minecraft_server.${VERSION}.jar

RUN apt update && apt install -y default-jre ca-certificates-java curl \
    # && curl -sL https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar -o /${MINECRAFT}
    && curl -sL https://papermc.io/api/v1/paper/${VERSION}/${BUILD}/download/paper-${BUILD}.jar -o /${MINECRAFT}

WORKDIR /data
VOLUME /data

# Automatically accept Minecraft EULA
RUN echo eula=true > /data/eula.txt

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

# Start Minecraft server
CMD java -Xms10G -Xmx10G \
    -XX:+UseG1GC \
    -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+DisableExplicitGC \
    -XX:+AlwaysPreTouch \
    -XX:G1NewSizePercent=30 \
    -XX:G1MaxNewSizePercent=40 \
    -XX:G1HeapRegionSize=8M \
    -XX:G1ReservePercent=20 \
    -XX:G1HeapWastePercent=5 \
    -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 \
    -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 \
    -XX:SurvivorRatio=32 \
    -XX:+PerfDisableSharedMem \
    -XX:MaxTenuringThreshold=1 \
    -Dusing.aikars.flags=https://mcflags.emc.gs \
    -Daikars.new.flags=true \
    -jar /${MINECRAFT} nogui
