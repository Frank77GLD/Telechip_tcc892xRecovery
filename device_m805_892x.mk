$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/YG/m805_892x/m805_892x-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/YG/m805_892x/overlay

PRODUCT_COPY_FILES += \
device/YG/m805_892x/recovery/init.m805_892x.rc:root/init.m805_892x.rc

PRODUCT_COPY_FILES += \
device/YG/m805_892x/lib/modules/ehci-hcd.ko:recovery/root/lib/modules/ehci-hcd.ko \
device/YG/m805_892x/lib/modules/ohci-hcd.ko:recovery/root/lib/modules/ohci-hcd.ko \
device/YG/m805_892x/lib/modules/tcc_mtd.ko:recovery/root/lib/modules/tcc_mtd.ko \
device/YG/m805_892x/lib/modules/tcc_nand.ko:recovery/root/lib/modules/tcc_nand.ko \
device/YG/m805_892x/lib/modules/tcc_ndd.ko:recovery/root/lib/modules/tcc_ndd.ko \
device/YG/m805_892x/lib/modules/ufsd.ko:recovery/root/lib/modules/ufsd.ko \
device/YG/m805_892x/recovery/init.m805_892x.rc:recovery/root/init.m805_892x.rc \
device/YG/m805_892x/recovery/ueventd.m805_892x.rc:recovery/root/ueventd.m805_892x.rc

LOCAL_PATH := device/YG/m805_892x
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_m805_892x
PRODUCT_DEVICE := m805_892x
