FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

RUN apk upgrade --no-cache && \
    apk add --no-cache bash curl vim jq

# Set Bash as the default shell
SHELL ["/bin/bash", "-c"]

# When the container starts, open an interactive Bash shell
CMD ["/bin/bash"]
