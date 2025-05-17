#!/bin/sh

set -eux

sudo chown -R runner:runner /home/runner/_work
sudo chown -R runner:runner /home/runner/actions-runner

export RUNNER_TOKEN=$(curl -s -X POST "${BASE_API_URL}/${ORGS_OR_REPOS}/${RUNNER_SCOPE}/actions/runners/registration-token" -H "accept: application/vnd.github.everest-preview+json" -H "authorization: token ${RUNNER_CFG_PAT}" | jq -r '.token')

unset GITHUB_ACCESS_TOKEN # Security

/home/runner/config.sh --unattended --url "https://github.com/${RUNNER_SCOPE}" --token "${RUNNER_TOKEN}" --runnergroup default --name "${HOSTNAME}" --work _work --disableupdate --ephemeral --replace --labels "${RUNNER_LABELS}"
/home/runner/run.sh
