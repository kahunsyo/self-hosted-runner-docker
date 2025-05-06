# self-hosted-runner-docker

Ephemeral self-hosted runner for Github Actions by Docker

## Token permission

Following permissions are required.

- classic token
  - repo #To use runner in private repo
  - admin:org
    - manage_runners:org

## Removing Offline runners

Runner is automatically removed from GitHub if it has not connected to GitHub Actions for more than 1 day.

To detail: https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/removing-self-hosted-runners
