#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_FOLDER := device/samsung/tuna

# CMHW
BOARD_HARDWARE_CLASS := $(DEVICE_FOLDER)/cmhw

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk
USE_CAMERA_STUB := true

# inherit from omap4-next
-include hardware/ti/omap4/BoardConfigCommon.mk

# Use the non-open-source parts, if they're present
-include vendor/samsung/tuna/BoardConfigVendor.mk

TARGET_BOARD_PLATFORM := omap4
TARGET_FPU_VARIANT := neon-fp16
TARGET_BOARD_OMAP_CPU := 4460
CAMERAHAL_TUNA := true
DOMX_TUNA := true
TI_CAMERAHAL_MAX_CAMERAS_SUPPORTED := 2
TI_CAMERAHAL_USES_LEGACY_DOMX_DCC := true
COMMON_GLOBAL_CFLAGS += -DDOMX_TUNA


# Force the screenshot path to CPU consumer
COMMON_GLOBAL_CFLAGS += -DFORCE_SCREENSHOT_CPU_PATH

OMAP_ENHANCEMENT_MULTIGPU := false

# Default values, if not overridden else where.
TARGET_BOARD_INFO_FILE := $(DEVICE_FOLDER)/board-info.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_FOLDER)/bluetooth

# For enabling some things that are OMAP_ENHANCEMENT's and are applicable to tuna...
OMAP_TUNA := true
COMMON_GLOBAL_CFLAGS += -DOMAP_TUNA

BOARD_KERNEL_BASE := 0x80000000

# Define kernel config for inline building
TARGET_KERNEL_CONFIG := slim_tuna_defconfig
BOARD_KERNEL_CMDLINE := androidboot.hardware=$(TARGET_BOOTLOADER_BOARD_NAME)
TARGET_KERNEL_SOURCE := kernel/samsung/tuna

# Use dlmalloc
MALLOC_IMPL := dlmalloc

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_BOOTLOADER_BOARD_NAME := tuna

BOARD_EGL_WORKAROUND_BUG_10194508 := true

TARGET_TI_HWC_HDMI_DISABLED := true

# Include HDCP keys
BOARD_CREATE_TUNA_HDCP_KEYS_SYMLINK := true

#BOARD_USES_HGL := true
#BOARD_USES_OVERLAY := true


# We don't support cursor layers, which when attempting to use them,
# results in no cursors (mouse or otherwise) displayed on the screen.
TARGET_DISABLE_CURSOR_LAYER := true

# libwvm needs this, among other things
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS

# set if the target supports FBIO_WAITFORVSYNC
TARGET_HAS_WAITFORVSYNC := true

# use FBIOPUT_DISPLAY instead of FBIOPUT_VSCREENINFO to refresh the display.
TARGET_USE_PAN_DISPLAY := true

TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

TARGET_NEEDS_BIONIC_MD5 := true

TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

# device-specific extensions to the updater binary
# inexplicable build errors with Lollipop...
TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_tuna
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_FOLDER)

# use the new recovery.fstab format
RECOVERY_FSTAB_VERSION = 2

TARGET_RECOVERY_FSTAB = $(DEVICE_FOLDER)/fstab.tuna
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12517376
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 685768704
BOARD_CACHEIMAGE_PARTITION_SIZE := 452984832
BOARD_USERDATAIMAGE_PARTITION_SIZE := 14539537408
BOARD_FLASH_BLOCK_SIZE := 4096

#TARGET_PROVIDES_INIT_RC := true
#TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# Disable journaling on system.img to save space.
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE           := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
#WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/bcmdhd.ko"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true


BOARD_HAL_STATIC_LIBRARIES := libdumpstate.tuna


BOARD_SEPOLICY_DIRS += \
        $(DEVICE_FOLDER)/sepolicy

