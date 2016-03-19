#!/system/bin/sh

DEVICE="/dev/block/platform/omap/omap_hsmmc.0/by-name/misc"

log_to_kernel() {
  echo "$*" > /dev/kmsg
}

create_misc_fs() {
    mke2fs -b 4096 ${DEVICE} || exit 1
    mount -t ext4 -o discard,nodev,noatime,nosuid,noexec,nomblk_io_submit ${DEVICE} /misc || exit 1
    mkdir /misc/smc || exit 1
    chmod 0770 /misc/smc || exit 1
    chown drmrpc:drmrpc /misc/smc || exit 1
    restorecon -R /misc/smc || exit 1
}

if [ ! -e /misc/smc ]; then
  # sha1 hash of the empty 4MB partition.
  EXPECTED_HASH="2bccbd2f38f15c13eb7d5a89fd9d85f595e23bc3"
  ACTUAL_HASH="`/system/bin/sha1sum ${DEVICE}`"
  if [ "${ACTUAL_HASH}" == "${EXPECTED_HASH}  ${DEVICE}" ]; then
    if create_misc_fs > /dev/kmsg 2>&1; then
      log_to_kernel "misc-fs-setup: successfully initialized /misc for SMC."
      setprop init.misc_fs.ready true
    else
      log_to_kernel "misc-fs-setup: initialization of /misc for SMC failed. SMC won't function!"
    fi
  else
    log_to_kernel "misc-fs-setup: unexpected hash '${ACTUAL_HASH}', skipping /misc filesystem creation. SMC won't function!"
  fi
else
  log_to_kernel "misc-fs-setup: /misc is already initialized for SMC, nothing to do."
  setprop init.misc_fs.ready true
fi

exit 0
