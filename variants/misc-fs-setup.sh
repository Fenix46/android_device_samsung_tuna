#!/system/bin/sh

DEVICE="/dev/block/platform/omap/omap_hsmmc.0/by-name/misc"

log_to_kernel() {
  echo "$*" > /dev/kmsg
}

create_misc_fs() {
    /system/bin/mke2fs -b 4096 ${DEVICE} || exit 1
    /system/bin/mount -t ext4 -o discard,nodev,noatime,nosuid,nomblk_io_submit ${DEVICE} /misc || exit 1
    mkdir /misc/smc || exit 1
    chmod 0770 /misc/smc || exit 1
    chown drmrpc:drmrpc /misc/smc || exit 1
}

if [ ! -e /misc/smc ]; then
  # sha256 hash of the empty 4MB partition.
  EXPECTED_HASH="bb9f8df61474d25e71fa00722318cd387396ca1736605e1248821cc0de3d3af8"
  ACTUAL_HASH="`/system/xbin/sha256sum ${DEVICE}`"
  if [ "${ACTUAL_HASH}" == "${EXPECTED_HASH}  ${DEVICE}" ]; then
    if create_misc_fs > /dev/kmsg 2>&1; then
      log_to_kernel "misc-fs-setup: successfully initialized /misc for SMC."
    else
      log_to_kernel "misc-fs-setup: initialization of /misc for SMC failed. SMC won't function!"
    fi
  else
    log_to_kernel "misc-fs-setup: unexpected hash '${ACTUAL_HASH}', skipping /misc filesystem creation. SMC won't function!"
  fi
else
  log_to_kernel "misc-fs-setup: /misc is already initialized for SMC, nothing to do."
fi

exit 0
