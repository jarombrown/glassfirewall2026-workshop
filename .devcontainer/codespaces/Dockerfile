FROM mcr.microsoft.com/devcontainers/javascript-node:24-bookworm@sha256:16eb68aa0d17eedaaf2566b180854fe4e506478e35aadf790fb02aa089024f13

ARG CHROME_VERSION=155.0.8059.79-1
ARG CHROME_DEVTOOLS_MCP_VERSION=1.10.1

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends ca-certificates curl ripgrep \
    && curl --http1.1 --fail --show-error --location \
        --retry 5 --retry-all-errors --retry-delay 2 \
        "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb" \
        -o /tmp/google-chrome.deb \
    && apt-get install -y --no-install-recommends /tmp/google-chrome.deb \
    && rm -f /tmp/google-chrome.deb \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global "chrome-devtools-mcp@${CHROME_DEVTOOLS_MCP_VERSION}" \
    && npm cache clean --force
