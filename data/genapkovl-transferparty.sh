#!/bin/sh -e

HOSTNAME="transferparty"
if [ -z "$HOSTNAME" ]; then
	echo "usage: $0 hostname"
	exit 1
fi

cleanup() {
	rm -rf "$tmp"
}

makefile() {
	OWNER="$1"
	PERMS="$2"
	FILENAME="$3"
	cat > "$FILENAME"
	chown "$OWNER" "$FILENAME"
	chmod "$PERMS" "$FILENAME"
}

rc_add() {
	mkdir -p "$tmp"/etc/runlevels/"$2"
	ln -sf /etc/init.d/"$1" "$tmp"/etc/runlevels/"$2"/"$1"
}

tmp="$(mktemp -d)"
trap cleanup EXIT

mkdir -p "$tmp"/etc
makefile root:root 0644 "$tmp"/etc/hostname <<EOF
$HOSTNAME
EOF

mkdir -p "$tmp"/etc/network
makefile root:root 0644 "$tmp"/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

mkdir -p "$tmp"/etc/apk
makefile root:root 0644 "$tmp"/etc/apk/world <<EOF
alpine-base
python3
py3-pillow
ffmpeg
agetty
wget
ntfs-3g
hfsfuse

coreutils
ethtool
hwids
doas
logrotate
lsof
lm_sensors
lxc
lxc-templates
nano
pciutils
strace
tmux
usbutils
v86d
vim
xtables-addons
curl
acct
arpon
arpwatch
awall
bridge-utils
bwm-ng
ca-certificates
conntrack-tools
cutter
cyrus-sasl
dhcpcd
dnsmasq
fping
fprobe
htop
igmpproxy
ip6tables
iproute2
iproute2-qos
iptables
iputils
nftables
iw
kea
ldns-tools
links
ncurses-terminfo
net-snmp
net-snmp-tools
nrpe
nsd
opennhrp
openvpn
pingu
ppp
quagga
quagga-nhrp
rng-tools
sntpc
socat
ssmtp
strongswan
sysklogd
tcpdump
tinyproxy
unbound
wireguard-tools
wireless-tools
wpa_supplicant
zonenotify
btrfs-progs
cksfv
dosfstools
cryptsetup
e2fsprogs
e2fsprogs-extra
efibootmgr
f2fs-tools
grub-bios
grub-efi
lvm2
lz4
mdadm
mkinitfs
mtools
nfs-utils
parted
rsync
sfdisk
syslinux
util-linux
xfsprogs
zstd
zfs
EOF

# just to ignore motd output
makefile root:root 0644 "$tmp"/etc/motd <<EOF

EOF

makefile root:root 0644 "$tmp"/etc/profile <<EOF
# banner
acc="\033[0;36m"
gray="\033[1;30m"
reset="\033[0m"

echo -e "\${gray}> > > \${acc}Welcome to \${gray}< < <\${reset}"
echo ""
echo -e "\${acc}████████\${gray}╗\${acc}██████\${gray}╗  \${acc}█████\${gray}╗ \${acc}███\${gray}╗   \${acc}██\${gray}╗\${acc}███████\${gray}╗\${acc}███████\${gray}╗\${acc}███████\${gray}╗\${acc}██████\${gray}╗ \${acc}██████\${gray}╗  \${acc}█████\${gray}╗ \${acc}██████\${gray}╗ \${acc}████████\${gray}╗\${acc}██\${gray}╗   \${acc}██\${gray}╗\${reset}"
echo -e "\${gray}╚══\${acc}██\${gray}╔══╝\${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}████\${gray}╗  \${acc}██\${gray}║\${acc}██\${gray}╔════╝\${acc}██\${gray}╔════╝\${acc}██\${gray}╔════╝\${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}██\${gray}╔══\${acc}██\${gray}╗╚══\${acc}██\${gray}╔══╝╚\${acc}██\${gray}╗ \${acc}██\${gray}╔╝\${reset}"
echo -e "   \${acc}██\${gray}║   \${acc}██████\${gray}╔╝\${acc}███████\${gray}║\${acc}██\${gray}╔\${acc}██\${gray}╗ \${acc}██\${gray}║\${acc}███████\${gray}╗\${acc}█████\${gray}╗  \${acc}█████\${gray}╗  \${acc}██████\${gray}╔╝\${acc}██████\${gray}╔╝\${acc}███████\${gray}║\${acc}██████\${gray}╔╝   \${acc}██\${gray}║    ╚\${acc}████\${gray}╔╝ \${reset}"
echo -e "   \${acc}██\${gray}║   \${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}██\${gray}╔══\${acc}██\${gray}║\${acc}██\${gray}║╚\${acc}██\${gray}╗\${acc}██\${gray}║╚════\${acc}██\${gray}║\${acc}██\${gray}╔══╝  \${acc}██\${gray}╔══╝  \${acc}██\${gray}╔══\${acc}██\${gray}╗\${acc}██\${gray}╔═══╝ \${acc}██\${gray}╔══\${acc}██\${gray}║\${acc}██\${gray}╔══\${acc}██\${gray}╗   \${acc}██\${gray}║     \${gray}╚\${acc}██\${gray}╔╝  \${reset}"
echo -e "   \${acc}██\${gray}║   \${acc}██\${gray}║  \${acc}██\${gray}║\${acc}██\${gray}║  \${acc}██\${gray}║\${acc}██\${gray}║ ╚\${acc}████\${gray}║\${acc}███████\${gray}║\${acc}██\${gray}║     \${acc}███████\${gray}╗\${acc}██\${gray}║  \${acc}██\${gray}║\${acc}██\${gray}║     \${acc}██\${gray}║  \${acc}██\${gray}║\${acc}██\${gray}║  \${acc}██\${gray}║   \${acc}██\${gray}║      \${acc}██\${gray}║   \${reset}"
echo -e "   \${gray}╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝      ╚═╝   \${reset}"

# setup mount area
mkdir /mnt/TransferParty
cd /mnt/TransferParty

# mount all the drives to our party folder, excluding our boot drive
echo "getting drives ready"

function join_by { local IFS="$1"; shift; echo "$*"; }

exclude=$(lsblk --list --noheadings --output maj,mountpoint | awk '$2 != "" {print $1}'
exclude="$exclude 1"
exclude=$(join_by , $exclude)

partitions=$(lsblk --list --output name,partn --noheadings --exclude $exclude | awk '$2 == "" {print $1}')

for p in $partitions; do
	echo " +++ mounting \$p ..."
	mkdir "/mnt/TransferParty/\$p"
	mount "\$p" "/mnt/TransferParty/\$p"
done

# run copyparty after 5 seconds
echo "Starting the party in 5 seconds ..."
echo "You can end the party with ctrl+c"
sleep 5s
python3 /etc/copyparty-sfx.py

# shutdown when copyparty ends
poweroff
EOF

makefile root:root 0644 "$tmp"/etc/inittab <<EOF
# /etc/inittab

::sysinit:/sbin/openrc sysinit
::sysinit:/sbin/openrc boot
::wait:/sbin/openrc default

# Set up a couple of getty's
tty1::respawn:/sbin/agetty --autologin root tty1 linux
tty2::respawn:/sbin/getty 38400 tty2
tty3::respawn:/sbin/getty 38400 tty3
tty4::respawn:/sbin/getty 38400 tty4
tty5::respawn:/sbin/getty 38400 tty5
tty6::respawn:/sbin/getty 38400 tty6

# Put a getty on the serial port
#ttyS0::respawn:/sbin/getty -L 115200 ttyS0 vt100

# Stuff to do for the 3-finger salute
::ctrlaltdel:/sbin/reboot

# Stuff to do before rebooting
::shutdown:/sbin/openrc shutdown
EOF

cp /home/build/copyparty-sfx.py "$tmp"/etc/

rc_add devfs sysinit
rc_add dmesg sysinit
rc_add mdev sysinit
rc_add hwdrivers sysinit
rc_add modloop sysinit

rc_add hwclock boot
rc_add modules boot
rc_add sysctl boot
rc_add hostname boot
rc_add bootmisc boot
rc_add syslog boot

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz
