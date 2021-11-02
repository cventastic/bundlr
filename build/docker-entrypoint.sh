#!/bin/sh
set -e
BUNDLR=/opt/bundler-node/
cd /opt
if [ ! -d $BUNDLR ]; then
  git clone https://github.com/Bundlr-Network/bundler-node.git
fi
cd bundler-node
cp .env.example .env
sed -i 's/^DATABASE_HOST.*/DATABASE_HOST=postgres/' $BUNDLR/.env
sed -i 's/^DATABASE_USER.*/DATABASE_USER=bundlr/' $BUNDLR/.env
sed -i 's/^DATABASE_PASSWORD.*/DATABASE_PASSWORD=changeme/' $BUNDLR/.env
sed -i 's/^DATABASE_NAME.*/DATABASE_NAME=bundlr/' $BUNDLR/.env
sed -i 's/^REDIS_HOST.*/REDIS_HOST=redis/' $BUNDLR/.env
sed -i 's/^REDIS_PORT.*/REDIS_PORT=6379/' $BUNDLR/.env

yarn
chmod +x $BUNDLR/scripts/reset_all.sh
$BUNDLR/scripts/reset_all.sh

yarn prod:build
yarn prod:start
