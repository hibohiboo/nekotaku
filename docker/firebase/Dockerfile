# https://firebase.google.com/docs/functions/get-started?authuser=0
# firebase cloud function はv6.11.5で動作
FROM node:6.14.4

# コンテナ上の作業ディレクトリ作成
WORKDIR /app

COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock

RUN yarn 
