#!/bin/sh

set -ux

PROJECT=${1:-"runner"}
export RUNNER_NAME=$(hostname)-$PROJECT
docker compose -p "$PROJECT" down --volumes --remove-orphans

while :; do
    docker compose -p "$PROJECT" up -d --remove-orphans --force-recreate --renew-anon-volumes
    sleep 30

    set +x
    while [ "$(docker compose -p "$PROJECT" ps runner -q --status running | wc -l)" -eq 1 ]; do
        sleep 5
    done
    set -x

    echo "Runner container has been exited or is not healthy."
    echo "Recreating the container..."
done
