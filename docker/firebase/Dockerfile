# https://firebase.google.com/docs/functions/get-started?authuser=0
# firebase cloud function はv6.11.5で動作
FROM node:10-alpine

RUN apk add --no-cache curl && \
    curl -L https://yarnpkg.com/install.sh | sh
# コンテナ上の作業ディレクトリ作成
WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm ci
