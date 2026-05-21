#!/bin/ash

if [ $(whoami) != "build" ]; then
  echo "must run build script as build user"
  echo "run: su - build"
fi

sh aports/scripts/mkimage.sh --tag edge \
  --outdir ~/iso \
  --arch x86_64 \
  --repository https://dl-cdn.alpinelinux.org/alpine/edge/main \
  --repository https://dl-cdn.alpinelinux.org/alpine/edge/community \
  --profile $1
