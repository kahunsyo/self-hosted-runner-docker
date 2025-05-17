FROM ghcr.io/actions/actions-runner

USER root

# Add your build tools!
RUN apt-get update && apt-get install -y curl

USER runner
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "bash" ]
CMD [ "/entrypoint.sh" ]
