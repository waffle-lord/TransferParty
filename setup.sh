#!/bin/ash

if [ -f ".no-setup" ]; then
  echo ""
  echo "setup should only be run once"
  echo ""
  echo "if you really want to run it again"
  echo "delete .no-setup file"
  return
fi

# add required packages
apk add abuild alpine-conf syslinux xorriso squashfs-tools grub mtools

# setup community repo
setup-apkrepos -c

# add nano and neovim editors. Options are nice :)
apk add neovim nano

# add build user and add them to the abuild group
adduser build -D
adduser build abuild

# copy data to build user
cp -R TransferParty/* /home/build
chown build:build -R /home/build/

# login to build user
su - build

# setup tmp directory
mkdir -pv ~/tmp
echo "export TMPDIR=~/tmp" > .profile

# clone aports repo
git clone --depth=1 https://github.com/alpinelinux/aports.git

touch .no-setup
