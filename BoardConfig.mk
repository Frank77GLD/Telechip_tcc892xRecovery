USE_CAMERA_STUB := true

# inherit from the proprietary version
-include device/YG/m805_892x/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := unknown
TARGET_CPU_ABI := armeabi
TARGET_BOOTLOADER_BOARD_NAME := m805_892x

BOARD_KERNEL_CMDLINE := console=null
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 4096

# fix this up by examining /proc/mtd on a running device
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00a00000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00a00000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x12c00000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x40000000
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_PREBUILT_KERNEL := device/YG/m805_892x/kernel

TARGET_PROVIDES_INIT_RC := true
TARGET_RECOVERY_INITRC := device/YG/m805_892x/recovery/init.rc

#TEST Line 1+2 met ¨ of niet?
BOARD_USE_USB_MASS_STORAGE_SWITCH := true
#TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun/file
BOARD_UMS_LUNFILE := "/sys/class/android_usb/android0/f_mass_storage/lun/file"

#TESTEN:
#ifndef BOARD_UMS_LUNFILE
#define BOARD_UMS_LUNFILE "/sys/devices/platform/usb_mass_storage/lun0/file"
#endif

#should be

#ifndef BOARD_UMS_LUNFILE
#define BOARD_UMS_LUNFILE "/sys/devices/platform/s3c6410-usbgadget/gadget/lun1/file"
#endif

# Storage Internal sd aka emmc
# Internal SD card for recovery and such
BOARD_HAS_SDCARD_INTERNAL := true
#BOARD_SDCARD_DEVICE_PRIMARY := /dev/block/mmcblk0p1
#BOARD_SDCARD_DEVICE_SECONDARY := /dev/block/mmcblk0
BOARD_SDCARD_DEVICE_PRIMARY := /dev/block/ndda1
BOARD_SDCARD_DEVICE_SECONDARY := /dev/block/ndda
#BOARD_SDEXT_DEVICE := /dev/block/platform/tcc-sdhc0.0/mmcblk0
#BOARD_SDEXT_DEVICE := /dev/block/platform/tcc-sdhc0.0
BOARD_SDEXT_DEVICE := /dev/block/mmcblk0

# Recovery
#BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/telechips/tcc8920st/recovery/recovery_keys.c
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_15x24.h\"
#BOARD_TOUCH_RECOVERY := true
BOARD_HAS_NO_SELECT_BUTTON := false
# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true
