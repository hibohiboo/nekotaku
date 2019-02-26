#!/bin/bash

# このシェルスクリプトのディレクトリの絶対パスを取得。
bin_dir=$(cd $(dirname $0) && pwd)
parent_dir=$bin_dir/..

cp $parent_dir/package.json $parent_dir/docker/firebase/package.json
cp $parent_dir/package-lock.json $parent_dir/docker/firebase/package-lock.json
cd $parent_dir/docker && docker-compose build