#!/bin/ash

if [ $(whoami) != "build" ]; then
  echo "must run build script as build user"
  echo "run: su - build"
  return
fi

# if the signing keys don't exist, create them
if [ ! -f ".abuild/build-*.rsa.pub" ]; then
  echo ">>> generating signing keys"
  abuild-keygen -a -n -q
fi

sh aports/scripts/mkimage.sh --tag edge \
  --outdir ~/iso \
  --arch x86_64 \
  --repository https://dl-cdn.alpinelinux.org/alpine/edge/main \
  --repository https://dl-cdn.alpinelinux.org/alpine/edge/community \
  --profile transferparty
