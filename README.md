# Minecraft Server Container

[www.minecraft.net](https://www.minecraft.net/en-us/download/server/)

## Build Command

```bash
docker build -t donpayne/minecraft:1.16.1 -t donpayne/minecraft:latest . && \
docker push donpayne/minecraft:1.16.1 && \
docker push donpayne/minecraft:latest
```
