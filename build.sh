#!/bin/ash

# make sure we are running as build user
if [ $(whoami) != "build" ]; then
  echo "must run build script as build user"
  echo "run: su - build"
  return
fi

# if the signing keys don't exist, create them
find /home/build/.abuild -maxdepth 1 -type f -name "build-*.rsa.pub" 2>/dev/null | grep -q .

if [ $? != 0 ]; then
  echo ">>> generating signing keys"
  abuild-keygen -a -n -q
fi

# run build
sh aports/scripts/mkimage.sh --tag edge \
  --outdir ~/iso \
  --arch x86_64 \
  --repository https://dl-cdn.alpinelinux.org/alpine/edge/main \
  --repository https://dl-cdn.alpinelinux.org/alpine/edge/community \
  --profile transferparty
