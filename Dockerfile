FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash curl vim jq

# Set Bash as the default shell
SHELL ["/bin/bash", "-c"]

# When the container starts, open an interactive Bash shell
CMD ["/bin/bash"]
