# Sample: https://github.com/CyanogenMod/android_device_htc_pyramid
# This file will make about 3 output files: device_$DEVICE-vendor.mk, DEVICE-vendor.mk, BoardConfigVendor.mk
# This file will make 1 new directory: overlay
#!/bin/sh
VENDOR=YG
DEVICE=m805_892x
#OUTDIR=vendor/$VENDOR/$DEVICE
OUTDIR=device/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk
#MAKEFILE=../../../$OUTDIR/device_$DEVICE-vendor.mk

(cat << EOF) > $MAKEFILE
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh
# Prebuilt libraries that are needed to build open-source libraries
# ad  \\ if you when you ad more lines
PRODUCT_COPY_FILES := \\
$OUTDIR/proprietary/lib/libril.so:obj/lib/libril.so

PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`wc -l proprietary-files | awk {'print $1'}`
DISM=`egrep -c '(^#|^$)' proprietary-files`
COUNT=`expr $COUNT - $DISM`
for FILE in `egrep -v '(^#|^$)' proprietary-files`; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ]; then
    LINEEND=""
  fi
  echo "  $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
done

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS := device/$VENDOR/$DEVICE/overlay

\$(call inherit-product, device/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/BoardConfigVendor.mk
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

#PRODUCT_SPECIFIC_DEFINES += TARGET_PRELINKER_MAP=\$(TOP)/device/telechips/legend/prelink-linux-arm-legend.map

#BOARD_GPS_LIBRARIES := libgps librpc

#BOARD_USES_GENERIC_AUDIO := false
#BOARD_USES_OLD_CAMERA_HACK := true
#USE_CAMERA_STUB := false
USE_CAMERA_STUB := true
#TARGET_USES_OLD_LIBSENSORS_HAL := true
#TARGET_SENSORS_NO_OPEN_CHECK := true
EOF

mkdir -p ../../../device/YG/m805_892x/overlay/packages/apps/Launcher2/res/layout
(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../device/YG/m805_892x/overlay/packages/apps/Launcher2/res/layout/all_apps.xml
<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright (C) 2012 The Android Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<!-- This file is generated by device/YG/m805_892x/setup-makefiles.sh -->

<!-- switch to all_apps_3d on devices that support RenderScript -->
<merge xmlns:android="http://schemas.android.com/apk/res/android">
<include layout="@layout/all_apps_3d" />
</merge>
EOF

