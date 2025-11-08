# Prowlarr with YGGTorrent Indexers

[![Auto Rebuild](https://github.com/almottier/prowlarr-ygg/actions/workflows/auto-rebuild.yml/badge.svg)](https://github.com/almottier/prowlarr-ygg/actions/workflows/auto-rebuild.yml)

An up-to-date Prowlarr Docker image with YGGTorrent indexers (Ygg-API and ygege) pre-installed.

```text
ghcr.io/almottier/prowlarr-ygg
```

## Features

- Based on the latest [hotio/prowlarr](https://hotio.dev/containers/prowlarr/) image
- Two YGGTorrent indexers pre-installed in `/config/Definitions/Custom/`:
  - [Clemv95/Ygg-API](https://gist.github.com/Clemv95/8bfded23ef23ec78f6678896f42a2b60) using [yggapi](https://yggapi.eu/)
  - [UwUDev/ygege](https://github.com/UwUDev/ygege)
- Automatically rebuilds when the base image or either indexer is updated
- Ready to use after container startup

## Usage

### cli

```bash
docker run --rm \
    --name prowlarr \
    -p 9696:9696 \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK=002 \
    -e TZ="Europe/Paris" \
    -v /<host_folder_config>:/config \
    ghcr.io/almottier/prowlarr-ygg
```

### compose

```yaml
services:
  prowlarr:
    container_name: prowlarr
    image: ghcr.io/almottier/prowlarr-ygg
    ports:
      - "9696:9696"
    environment:
      - PUID=1000
      - PGID=1000
      - UMASK=002
      - TZ=Europe/Paris
    volumes:
      - /<host_folder_config>:/config
```

## Configuration

After starting the container, both YGGTorrent indexers (Ygg-API and ygege) will be available in Prowlarr's indexer settings:

![](./Screenshot.png)
