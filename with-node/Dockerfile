FROM us-west1-docker.pkg.dev/test-ai-243511/api/alpine-chrome:latest

USER root
RUN apk add --no-cache \
      tini make gcc g++ python3 git nodejs npm yarn \
    && npm install -g npm@11.12.1 \
    && apk del npm \
    && ln -sf /usr/local/bin/npm /usr/bin/npm \
    && ln -sf /usr/local/bin/npx /usr/bin/npx \
    && npm config --location=global delete python 2>/dev/null; \
       npm config --location=global delete globalignorefile 2>/dev/null; true
USER chrome
ENTRYPOINT ["tini", "--"]
