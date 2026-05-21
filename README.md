# TransferParty
A live ISO to transfer data off a computer using CopyParty

# Setting up the Build Environment
- install alpine standard on a computer or VM
- install git with `apk add git`
- clone this repo and run the `setup.sh` script to setup the build environment
```sh
git clone https://github.com/waffle-lord/TransferParty.git
cd TransferParty
./setup.sh
```

# Updating Profiles
- pull this repo's changes
- run `setup.sh` again
```sh
git pull
./setup.sh
```

# Building TransferParty
- login as the build user
```sh
su - build
```
- run the build script with the transferparty profile
```sh
./build transferparty
```
