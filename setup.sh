#!/bin/ash

if [ $(whoami) == build ]; then
  echo "don't run setup as build"
  return
fi

if [ -f ".no-setup" ]; then
  # update script files only
  echo ">>> copying transferparty data"
  cp data/* /home/build/aports/scripts
  cp build.sh /home/build

  echo ">>> downloading copyparty"
  wget -O /home/build/copyparty-sfx.py https://github.com/9001/copyparty/releases/latest/download/copyparty-sfx.py

  chown build:build -R /home/build/aports/scripts
  chown build:build /home/build/copyparty-sfx.py
  chown build:build /home/build/build.sh
  return
fi

# add required packages
echo ">>> adding required packages"
apk add abuild alpine-conf syslinux xorriso squashfs-tools grub mtools

# setup community repo
echo ">>> adding community repo"
1 | setup-apkrepos -c

# add nano and neovim editors. Options are nice :)
echo ">>> adding nano and neovim"
apk add neovim nano

# add build user and add them to the abuild group
echo ">>> adding build user"
adduser build -D
adduser build abuild

# setup tmp directory
echo ">>> adding build user tmp dir"
mkdir -pv /home/build/tmp
echo "export TMPDIR=~/tmp" > /home/build/.profile


# clone aports repo
echo ">>> cloning aports repo"
git clone --depth=1 https://github.com/alpinelinux/aports.git /home/build/aports


# copy data to build user
echo ">>> copying transferparty data"
cp data/* /home/build/aports/scripts
cp build.sh /home/build

# make sure build owns its files
echo ">>> updating build ownership"
chown build:build -R /home/build/

touch .no-setup

echo ">>> done"
