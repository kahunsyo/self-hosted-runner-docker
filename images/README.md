# Image

This directory contains Dockerfile for runner base image.

## Build example

Example for ARM, Linux, Runner v2.324.0

```shell
docker image build --build-arg TARGETOS=linux --build-arg TARGETARCH=arm64 ./ubuntu-latest
```

## Update packge version

Run following commnad and replace `ARG` line in all Dockerfile.

```shell
sh update-build-args.sh
```

Scripts causing error like bellow means your IP hit API rate limit. Try later, again.

```txt
jq: error (at <stdin>:1): Cannot index string with string "name"
```

