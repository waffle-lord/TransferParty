profile_transferparty() {
	profile_extended
	profile_abbrev="transferparty"
	title="TransferParty"
	desc="Live ISO for transfering data using CopyParty"
	apks="$apks python3 py3-pillow ffmpeg agetty wget ntfs-3g hfsfuse iwd impala"

	local _k _a
	for _k in $kernel_flavors; do
		apks="$apks linux-$_k"
		for _a in $kernel_addons; do
			apks="$apks $_a-$_k"
		done
	done
	
  apkovl="aports/scripts/genapkovl-transferparty.sh"
}
