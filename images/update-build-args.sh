#!/bin/sh

# Update build-args

set -eux

# Get the latest versions
RUNNER_VERSION=$(curl -LsS -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/repos/actions/runner/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
RUNNER_CONTAINER_HOOKS_VERSION=$(curl -LsS -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/repos/actions/runner-container-hooks/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
DOCKER_VERSION=$(curl -LsS -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/repos/docker/cli/tags" | jq -r '.[].name' | ggrep -v '^v*-rc*$' | head -n 1 | sed 's/^v//')
BUILDX_VERSION=$(curl -LsS -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/repos/docker/buildx/releases/latest" | jq -r '.tag_name' | sed 's/^v//')

# Update ARGs in Dockerfiles
gfind . -type f -name "Dockerfile" | while read line; do
    gsed -i 's/^ARG RUNNER_VERSION=.*$/ARG RUNNER_VERSION='"${RUNNER_VERSION}"'/' "$line"
    gsed -i 's/^ARG RUNNER_CONTAINER_HOOKS_VERSION=.*$/ARG RUNNER_CONTAINER_HOOKS_VERSION='"${RUNNER_CONTAINER_HOOKS_VERSION}"'/' "$line"
    gsed -i 's/^ARG DOCKER_VERSION=.*$/ARG DOCKER_VERSION='"${DOCKER_VERSION}"'/' "$line"
    gsed -i 's/^ARG BUILDX_VERSION=.*$/ARG BUILDX_VERSION='"${BUILDX_VERSION}"'/' "$line"
done
