#!/bin/bash

# このシェルスクリプトのディレクトリの絶対パスを取得。
bin_dir=$(cd $(dirname $0) && pwd)
container_name=${1:-nekotaku}

# $container_nameの有無をgrepで調べる
docker ps | grep $container_name

# grepの戻り値$?の評価。 grep戻り値 0:一致した 1:一致しなかった
if [ $? -eq 0 ]; then
  # 一致したときの処理
  cd $bin_dir/../docker && docker-compose exec -e NODE_ENV=production $container_name npm run build
else
  # 一致しなかった時の処理
  # コンテナを立ち上げて接続
  # ビルド結果を一時ディレクトリにコピー
  cd $bin_dir/../docker && docker-compose run -e NODE_ENV=production $container_name /bin/sh -c 'npm run build && cp -r /app/dist /app/tmp/'
fi


