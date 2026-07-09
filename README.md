# VRC HLS Service

A small Dockerized RTMP-to-HLS service for VRChat streaming experiments.

The container runs nginx with the RTMP module enabled. Publishers send an RTMP stream to the `live` application, and nginx writes short HLS segments that can be played from the HTTP endpoint.

## What It Provides

- RTMP ingest on port `1935`
- HLS playback on port `8080`
- Health endpoint at `/health`
- Runtime-configurable ports through environment variables

## Requirements

- Docker
- An RTMP publisher such as OBS
- An HLS-capable player such as VLC, Safari, or a browser player

## Build

```bash
docker build -t vrc-hls-zeabur:local .
```

## Run

```bash
docker run --rm -p 8080:8080 -p 1935:1935 vrc-hls-zeabur:local
```

Check the service:

```bash
curl http://localhost:8080/health
```

Expected response:

```text
ok
```

## Stream URLs

Publish RTMP to:

```text
rtmp://localhost:1935/live
```

Use any stream key. For example, with stream key `vrc`, the HLS playlist is available at:

```text
http://localhost:8080/hls/vrc.m3u8
```

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| `PORT` | `8080` | HTTP port for health checks and HLS playback. |
| `RTMP_PORT` | `1935` | RTMP ingest port. |

Example:

```bash
docker run --rm -e PORT=3000 -e RTMP_PORT=1936 -p 3000:3000 -p 1936:1936 vrc-hls-zeabur:local
```

## Development Workflow

1. Edit `Dockerfile` or `nginx.conf.template`.
2. Build the local image.
3. Run the container.
4. Check `/health`.
5. Publish a test stream and verify the HLS playlist.

## Docker Image Publishing

Images are built and published automatically by GitHub Actions when changes are pushed to `main` or version tags such as `v1.0.0` are created.

The Docker Hub image name is:

```text
megasan/vrc-hls-zeabur
```
