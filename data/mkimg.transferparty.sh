profile_transferparty() {
	profile_standard
	profile_abbrev="transferparty"
	title="TransferParty"
	desc="Live ISO for transfering data using CopyParty"
	arch="x86 x86_64"
	kernel_addons="xtables-addons zfs"
	boot_addons="amd-ucode intel-ucode"
	initrd_ucode="/boot/amd-ucode.img /boot/intel-ucode.img"
	apks="$apks"

	local _k _a
	for _k in $kernel_flavors; do
		apks="$apks linux-$_k"
		for _a in $kernel_addons; do
			apks="$apks $_a-$_k"
		done
	done
	apks="$apks linux-firmware linux-firmware-none"
  apkovl="aports/scripts/genapkovl-transferparty.sh"
}
