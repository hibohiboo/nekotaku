#!/bin/bash

bin_dir=$(cd $(dirname $0) && pwd)
parent_dir=$(cd $bin_dir/.. && pwd)
docker_dir=$(cd $parent_dir/docker && pwd)
container_name=${1:-nekotaku}

cd $docker_dir && docker-compose run -e NODE_ENV=production $container_name /bin/sh -c 'npm run build:browser && cp -r /app/dist /app/tmp/'

vendor_dir=$(cd $parent_dir/.. && pwd)
root_dir=$(cd $vendor_dir/.. && pwd)
public_dir=$(cd $root_dir/app/public && pwd)
dist_dir=$(cd $parent_dir/dist/tmp/dist && pwd)

rm -rf $public_dir/nekotaku
cp -r $dist_dir $public_dir/nekotaku
