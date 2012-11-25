#!/bin/sh
# like this one: https://github.com/Asure/android_device_telechips_tcc8902/blob/master/extract-files.sh
## This file will make 1 output files: device_$DEVICE-vendor-blobs.mk
# last it will start: ./setup-makefiles.sh
adb wait-for-devices
DEVICE=m805_892x
MANUFACTURER=YG

# mkdir -p ../../../device/$MANUFACTURER/$DEVICE/proprietary

BASE=../../../device/$MANUFACTURER/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `egrep -v '(^#|^$)' proprietary-files`; do
DIR=`dirname $FILE`
  if [ ! -d $BASE/$DIR ]; then
mkdir -p $BASE/$DIR
  fi
adb pull /system/$FILE $BASE/$FILE
done

# Note: akmd is needed for rotation/g-sensor, maybe needed for M701 later on
#adb pull /system/bin/akmd ../../../device/telechips/$DEVICE/proprietary/akmd
# Note: No working bluetooth found in any kernel so far. High hopes unfounded?
#adb pull /system/bin/bluetoothd ../../../device/telechips/$DEVICE/proprietary/bluetoothd
# adb pull /system/lib/libcamera.so ../../../device/telechips/$DEVICE/proprietary/libcamera.so

chmod 755 ../../../device/$MANUFACTURER/$DEVICE/proprietary/*

# What is listed ad PRODUCT_COPY_FILES := \\ those no need listing in: PRODUCT_COPY_FILES += \\
# werking uitzoeken.
(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../device/$MANUFACTURER/$DEVICE/device_$DEVICE-vendor-blobs.mk

PRODUCT_COPY_FILES := \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libril.so:obj/lib/libril.so
#$OUTDIR/proprietary/lib/libril.so:obj/lib/libril.so

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/key_921600.psr:root/key_921600.psr \\
device/__MANUFACTURER__/__DEVICE__/proprietary/key_3000000.psr:root/key_3000000.psr \\
device/__MANUFACTURER__/__DEVICE__/proprietary/ts.conf:root/ts.conf

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/app/A777_FactoryTest.apk:system/app/A777_FactoryTest.apk \\
device/__MANUFACTURER__/__DEVICE__/proprietary/app/Vending.apk:system/app/Vending.apk

#Executable files
#bin/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/bugmailer.sh:system/bin/bugmailer.sh \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/busybox:system/bin/busybox \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/chkntfs:system/bin/chkntfs \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/flash_eraseall:system/bin/flash_eraseall \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/hostapd:system/bin/hostapd \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/hostapd_cli:system/bin/hostapd_cli \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/hostapd_wps:system/bin/hostapd_wps \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/iwconfig:system/bin/iwconfig \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/iwlist:system/bin/iwlist \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/make_ext4fs:system/bin/make_ext4fs \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/mem:system/bin/mem \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/mkntfs:system/bin/mkntfs \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/netd:system/bin/netd \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/rild:system/bin/rild \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/send_bug:system/bin/send_bug \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/setup_fs:system/bin/setup_fs \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/tc:system/bin/tc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/vold:system/bin/vold \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/wpa_cli:system/bin/wpa_cli \\
device/__MANUFACTURER__/__DEVICE__/proprietary/bin/wpa_supplicant:system/bin/wpa_supplicant

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/apns-conf.xml:system/etc/apns-conf.xml \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/dhcpcd.conf:system/etc/dhcpcd.conf \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/init.goldfish.sh:system/etc/init.goldfish.sh \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/media_profiles.xml:system/etc/media_profiles.xml \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/mkshrc:system/etc/mkshrc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/vold.fstab:system/etc/vold.fstab \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/bluetooth/blacklist.conf:system/etc/bluetooth/blacklist.conf

# Pull permissions
#device/__MANUFACTURER__/__DEVICE__/proprietary/etc/permissions/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \\ vanuit CM
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/permissions/features.xml:system/etc/permissions/features.xml

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/ppp/chap-secrets:system/etc/ppp/chap-secrets \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/ppp/gprs-connect-chat:system/etc/ppp/gprs-connect-chat \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/ppp/init.gprs-pppd:system/etc/ppp/init.gprs-pppd \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/ppp/ip-down:system/etc/ppp/ip-down \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/ppp/ip-up:system/etc/ppp/ip-up \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/ril/ril.xml:system/etc/ril/ril.xml

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/wifi/hostapd.conf:system/etc/wifi/hostapd.conf \\
device/__MANUFACTURER__/__DEVICE__/proprietary/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

#framework/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/framework/com.android.future.usb.accessory.jar:system/framework/com.android.future.usb.accessory.jar \\
device/__MANUFACTURER__/__DEVICE__/proprietary/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \\
device/__MANUFACTURER__/__DEVICE__/proprietary/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libextenddisplay.so:system/lib/libextenddisplay.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libhdmi.so:system/lib/libhdmi.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libhwui.so:system/lib/libhwui.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libjni_googlepinyinime_4.so:system/lib/libjni_googlepinyinime_4.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libjni_googlepinyinime_latinime_4.so:system/lib/libjni_googlepinyinime_latinime_4.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libmtdutils1.so:system/lib/libmtdutils1.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libnvomxadaptor.so:system/lib/libnvomxadaptor.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.aacdec.so:system/lib/libOMX.TCC.aacdec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.aacenc.so:system/lib/libOMX.TCC.aacenc.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.apedec.so:system/lib/libOMX.TCC.apedec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.audio.so:system/lib/libOMX.TCC.audio.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.base.so:system/lib/libOMX.TCC.base.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.flacdec.so:system/lib/libOMX.TCC.flacdec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.Google.vpxdec.so:system/lib/libOMX.TCC.Google.vpxdec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.mp2dec.so:system/lib/libOMX.TCC.mp2dec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.mp3dec.so:system/lib/libOMX.TCC.mp3dec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.mp3enc.so:system/lib/libOMX.TCC.mp3enc.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.pcmdec.so:systemlib/libOMX.TCC.pcmdec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.spdif.so:system/lib/libOMX.TCC.spdif.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.VideoDec.so:system/lib/libOMX.TCC.VideoDec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.VideoEnc.so:system/lib/libOMX.TCC.VideoEnc.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.vorbisdec.so:system/lib/libOMX.TCC.vorbisdec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.VPUDec.so:system/lib/libOMX.TCC.VPUDec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.VPUEnc.so:system/lib/libOMX.TCC.VPUEnc.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libOMX.TCC.wmadec.so:system/lib/libOMX.TCC.wmadec.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libpcmhost_skype.so:system/lib/libpcmhost_skype.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libTCC_ASF_DMX.so:system/lib/libTCC_ASF_DMX.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libTCC_CDK_CONFIG.so:system/lib/libTCC_CDK_CONFIG.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libTCC_Decoder.so:system/lib/libTCC_Decoder.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libTCC_Encoder.so:system/lib/libTCC_Encoder.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libtcc-evdo-ril.so:system/lib/libtcc-evdo-ril.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libTCC_OMXCore.so:system/lib/libTCC_OMXCore.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libTCC_RM_DMX.so:system/lib/libTCC_RM_DMX.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libtinyalsa.so:system/lib/libtinyalsa.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libttspico.so:system/lib/libttspico.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libvideochat_stabilize.so:system/lib/libvideochat_stabilize.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libvideoeditor_jni.so:system/lib/libvideoeditor_jni.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libvideoeditorplayer.so:system/lib/libvideoeditorplayer.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libvoicesearch.so:system/lib/libvoicesearch.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/libwnndict.so:system/lib/libwnndict.so

#lib/egl/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/egl/egl.cfg:system/lib/egl/egl.cfg

#lib/hw/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/hw/audio.primary.tcc892x.so:system/lib/hw/audio.primary.tcc892x.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/proprietary/lib/hw/audio.primary.tcc892x.so:system/lib/hw/audio.primary.tcc892x.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/hw/camera.tcc892x.so:system/lib/hw/camera.tcc892x.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/hw/gps.tcc892x.so:system/lib/hw/gps.tcc892x.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/hw/lights.tcc892x.so:system/lib/hw/lights.tcc892x.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/hw/sensors.tcc892x.so:system/lib/hw/sensors.tcc892x.so

#lib/modules/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/modules/vpu_decoder.ko:system/lib/modules/vpu_decoder.ko \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/modules/vpu_decoder_ext.ko:system/lib/modules/vpu_decoder_ext.ko \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/modules/vpu_encoder.ko:system/lib/modules/vpu_encoder.ko \\
device/__MANUFACTURER__/__DEVICE__/proprietary/lib/modules/vpu_manager.ko:system/lib/modules/vpu_manager.ko

#media/audio?
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Alarm_Beep_01.ogg:system/media/audio/alarms/Alarm_Beep_01.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Alarm_Beep_02:system/media/audio/alarms/Alarm_Beep_02.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Alarm_Beep_03:system/media/audio/alarms/Alarm_Beep_03.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Alarm_Buzzer.ogg:system/media/audio/alarms/Alarm_Buzzer.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Alarm_Classic.ogg:system/media/audio/alarms/Alarm_Classic.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Alarm_Rooster_02.ogg:system/media/audio/alarms/Alarm_Rooster_02.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Barium.ogg:system/media/audio/alarms/Barium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Cesium.ogg:system/media/audio/alarms/Cesium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Plutonium.ogg:system/media/audio/alarms/Plutonium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/alarms/Scandium.ogg:system/media/audio/alarms/Scandium.ogg

#media/audio/notifications/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Aldebaran.ogg:system/media/audio/notifications/Aldebaran.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Altair.ogg:system/media/audio/notifications/Altair.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Antares.ogg:system/media/audio/notifications/Antares.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Antimony.ogg:system/media/audio/notifications/Antimony.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/arcturus.ogg:system/media/audio/notifications/arcturus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Argon.ogg:system/media/audio/notifications/Argon.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Beat_Box_Android.ogg:system/media/audio/notifications/Beat_Box_Android.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Beryllium.ogg:system/media/audio/notifications/Beryllium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Betelgeuse.ogg:system/media/audio/notifications/Betelgeuse.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/CaffeineSnake.ogg:system/media/audio/notifications/CaffeineSnake.ogg
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Canopus.ogg:system/media/audio/notifications/Canopus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Capella.ogg:system/media/audio/notifications/Capella.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Castor.ogg:system/media/audio/notifications/Castor.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/CetiAlpha.ogg:system/media/audio/notifications/CetiAlpha.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Cobalt.ogg:system/media/audio/notifications/Cobalt.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Cricket.ogg:system/media/audio/notifications/Cricket.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/DearDeer.ogg:system/media/audio/notifications/DearDeer.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Deneb.ogg:system/media/audio/notifications/Deneb.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Doink.ogg:system/media/audio/notifications/Doink.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/DontPanic.ogg:system/media/audio/notifications/DontPanic.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Drip.ogg:system/media/audio/notifications/Drip.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Electra.ogg:system/media/audio/notifications/Electra.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/F1_MissedCall.ogg:system/media/audio/notifications/F1_MissedCall.ogg

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/F1_New_MMS.ogg:system/media/audio/notifications/F1_New_MMS.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/F1_New_SMS.ogg:system/media/audio/notifications/F1_New_SMS.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Fluorine.ogg:system/media/audio/notifications/Fluorine.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Fomalhaut.ogg:system/media/audio/notifications/Fomalhaut.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Gallium.ogg:system/media/audio/notifications/Gallium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Heaven.ogg:system/media/audio/notifications/Heaven.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Helium.ogg:system/media/audio/notifications/Helium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Highwire.ogg:system/media/audio/notifications/Highwire.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Iridium.ogg:system/media/audio/notifications/Iridium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Krypton.ogg:system/media/audio/notifications/Krypton.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/KzurbSonar.ogg:system/media/audio/notifications/KzurbSonar.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Merope.ogg:system/media/audio/notifications/Merope.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/moonbeam.ogg:system/media/audio/notifications/moonbeam.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/OnTheHunt.ogg:system/media/audio/notifications/OnTheHunt.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Palladium.ogg:system/media/audio/notifications/Palladium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/pixiedust.ogg:system/media/audio/notifications/pixiedust.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/pizzicato.ogg:system/media/audio/notifications/pizzicato.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Plastic_Pipe.ogg:system/media/audio/notifications/Plastic_Pipe.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Polaris.ogg:system/media/audio/notifications/Polaris.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Pollux.ogg:system/media/audio/notifications/Pollux.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Procyon.ogg:system/media/audio/notifications/Procyon.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Radon.ogg:system/media/audio/notifications/Radon.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/regulus.ogg:system/media/audio/notifications/regulus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Rubidium.ogg:system/media/audio/notifications/Rubidium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Selenium.ogg:system/media/audio/notifications/Selenium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/sirius.ogg:system/media/audio/notifications/sirius.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Sirrah.ogg:system/media/audio/notifications/Sirrah.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/SpaceSeed.ogg:system/media/audio/notifications/SpaceSeed.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Strontium.ogg:system/media/audio/notifications/Strontium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/TaDa.ogg:system/media/audio/notifications/TaDa.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Thallium.ogg:system/media/audio/notifications/Thallium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Tinkerbell.ogg:system/media/audio/notifications/Tinkerbell.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/tweeters.ogg:system/media/audio/notifications/tweeters.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/vega.ogg:system/media/audio/notifications/vega.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Voila.ogg:system/media/audio/notifications/Voila.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Xenon.ogg:system/media/audio/notifications/Xenon.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/notifications/Zirconium.ogg:system/media/audio/notifications/Zirconium.ogg

#media/audio/ringtones/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/ANDROMEDA.ogg:system/media/audio/ringtones/ANDROMEDA.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Aquila.ogg:system/media/audio/ringtones/Aquila.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/ArgoNavis.ogg:system/media/audio/ringtones/ArgoNavis.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Backroad.ogg:system/media/audio/ringtones/Backroad.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/BeatPlucker.ogg:system/media/audio/ringtones/BeatPlucker.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/BentleyDubs.ogg:system/media/audio/ringtones/BentleyDubs.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Big_Easy.ogg:system/media/audio/ringtones/Big_Easy.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/BirdLoop.ogg:system/media/audio/ringtones/BirdLoop.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Bollywood.ogg:system/media/audio/ringtones/Bollywood.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/BOOTES.ogg:system/media/audio/ringtones/BOOTES.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/BussaMove.ogg:system/media/audio/ringtones/BussaMove.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Cairo.ogg:system/media/audio/ringtones/Cairo.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Calypso_Steel.ogg:system/media/audio/ringtones/Calypso_Steel.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/CANISMAJOR.ogg:system/media/audio/ringtones/CANISMAJOR.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/CaribbeanIce.ogg:system/media/audio/ringtones/CaribbeanIce.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Carina.ogg:system/media/audio/ringtones/Carina.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/CASSIOPEIA.ogg:system/media/audio/ringtones/CASSIOPEIA.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Centaurus.ogg:system/media/audio/ringtones/Centaurus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Champagne_Edition.ogg:system/media/audio/ringtones/Champagne_Edition.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Club_Cubano.ogg:system/media/audio/ringtones/Club_Cubano.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/CrayonRock.ogg:system/media/audio/ringtones/CrayonRock.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/CrazyDream.ogg:system/media/audio/ringtones/CrazyDream.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/CurveBall.ogg:system/media/audio/ringtones/CurveBall.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Cygnus.ogg:system/media/audio/ringtones/Cygnus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/DancinFool.ogg:system/media/audio/ringtones/DancinFool.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Ding.ogg:system/media/audio/ringtones/Ding.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/DonMessWivIt.ogg:system/media/audio/ringtones/DonMessWivIt.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Draco.ogg:system/media/audio/ringtones/Draco.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/DreamTheme.ogg:system/media/audio/ringtones/DreamTheme.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Eastern_Sky.ogg:system/media/audio/ringtones/Eastern_Sky.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Enter_the_Nexus.ogg:system/media/audio/ringtones/Enter_the_Nexus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Eridani.ogg:system/media/audio/ringtones/Eridani.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/EtherShake.ogg:system/media/audio/ringtones/EtherShake.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/FreeFlight.ogg:system/media/audio/ringtones/FreeFlight.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/FriendlyGhost.ogg:system/media/audio/ringtones/FriendlyGhost.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Funk_Yall.ogg:system/media/audio/ringtones/Funk_Yall.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/GameOverGuitar.ogg:system/media/audio/ringtones/GameOverGuitar.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Gimme_Mo_Town.ogg:system/media/audio/ringtones/Gimme_Mo_Town.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Glacial_Groove.ogg:system/media/audio/ringtones/Glacial_Groove.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Growl.ogg:system/media/audio/ringtones/Growl.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/HalfwayHome.ogg:system/media/audio/ringtones/HalfwayHome.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/hydra.ogg:system/media/audio/ringtones/hydra.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/InsertCoin.ogg:system/media/audio/ringtones/InsertCoin.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/LoopyLounge.ogg:system/media/audio/ringtones/LoopyLounge.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/LoveFlute.ogg:system/media/audio/ringtones/LoveFlute.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Lyra.ogg:system/media/audio/ringtones/Lyra.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Machina.ogg:system/media/audio/ringtones/Machina.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/MidEvilJaunt.ogg:system/media/audio/ringtones/MidEvilJaunt.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/MildlyAlarming.ogg:system/media/audio/ringtones/MildlyAlarming.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Nairobi.ogg:system/media/audio/ringtones/Nairobi.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Nassau.ogg:system/media/audio/ringtones/Nassau.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/NewPlayer.ogg:system/media/audio/ringtones/NewPlayer.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Noises1.ogg:system/media/audio/ringtones/Noises1.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Noises2.ogg:system/media/audio/ringtones/Noises2.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Noises3.ogg:system/media/audio/ringtones/Noises3.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/No_Limits.ogg:system/media/audio/ringtones/No_Limits.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/OrganDub.ogg:system/media/audio/ringtones/OrganDub.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Orion.ogg:system/media/audio/ringtones/Orion.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Paradise_Island.ogg:system/media/audio/ringtones/Paradise_Island.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Pegasus.ogg:system/media/audio/ringtones/Pegasus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/PERSEUS.ogg:system/media/audio/ringtones/PERSEUS.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Playa.ogg:system/media/audio/ringtones/Playa.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Pyxis.ogg:system/media/audio/ringtones/Pyxis.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Revelation.ogg:system/media/audio/ringtones/Revelation.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Rigel.ogg:system/media/audio/ringtones/Rigel.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Ring_Classic_02.ogg:system/media/audio/ringtones/Ring_Classic_02.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Ring_Digital_02.ogg:system/media/audio/ringtones/Ring_Digital_02.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Ring_Synth_02.ogg:system/media/audio/ringtones/Ring_Synth_02.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Ring_Synth_04.ogg:system/media/audio/ringtones/Ring_Synth_04.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Road_Trip.ogg:system/media/audio/ringtones/Road_Trip.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/RomancingTheTone.ogg:system/media/audio/ringtones/RomancingTheTone.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Safari.ogg:system/media/audio/ringtones/Safari.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Savannah.ogg:system/media/audio/ringtones/Savannah.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Scarabaeus.ogg:system/media/audio/ringtones/Scarabaeus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Sceptrum.ogg:system/media/audio/ringtones/Sceptrum.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Seville.ogg:system/media/audio/ringtones/Seville.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Shes_All_That.ogg:system/media/audio/ringtones/Shes_All_That.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/SilkyWay.ogg:system/media/audio/ringtones/SilkyWay.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/SitarVsSitar.ogg:system/media/audio/ringtones/SitarVsSitar.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Solarium.ogg:system/media/audio/ringtones/Solarium.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/SpringyJalopy.ogg:system/media/audio/ringtones/SpringyJalopy.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Steppin_Out.ogg:system/media/audio/ringtones/Steppin_Out.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Terminated.ogg:system/media/audio/ringtones/Terminated.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Testudo.ogg:system/media/audio/ringtones/Testudo.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Third_Eye.ogg:system/media/audio/ringtones/Third_Eye.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Thunderfoot.ogg:system/media/audio/ringtones/Thunderfoot.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/TwirlAway.ogg:system/media/audio/ringtones/TwirlAway.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/URSAMINOR.ogg:system/media/audio/ringtones/URSAMINOR.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/VeryAlarmed.ogg:system/media/audio/ringtones/VeryAlarmed.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/Vespa.ogg:system/media/audio/ringtones/Vespa.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ringtones/World.ogg:system/media/audio/ringtones/World.ogg

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/camera_click.ogg:system/media/audio/ui/camera_click.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/camera_focus.ogg:system/media/audio/ui/camera_focus.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/Dock.ogg:system/media/audio/ui/Dock.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/Effect_Tick.ogg:system/media/audio/ui/Effect_Tick.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/KeypressDelete.ogg:system/media/audio/ui/KeypressDelete.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/KeypressReturn.ogg:system/media/audio/ui/KeypressReturn.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/KeypressSpacebar.ogg:system/media/audio/ui/KeypressSpacebar.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/KeypressStandard.ogg:system/media/audio/ui/KeypressStandard.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/Lock.ogg:system/media/audio/ui/Lock.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/Undock.ogg:system/media/audio/ui/Undock.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/Unlock.ogg:system/media/audio/ui/Unlock.ogg \\
device/__MANUFACTURER__/__DEVICE__/proprietary/media/audio/ui/VideoRecord.ogg:system/media/audio/ui/VideoRecord.ogg

#usr/idc/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/ak4187-TouchScreen.idc:system/usr/idc/ak4187-TouchScreen.idc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/Goodix-TouchScreen.idc:system/usr/idc/Goodix-TouchScreen.idc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/qwerty.idc:system/usr/idc/qwerty.idc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/qwerty2.idc:system/usr/idc/qwerty2.idc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/tcc-ts.idc:system/usr/idc/tcc-ts.idc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/tcc-ts-goodix-cap.idc:system/usr/idc/tcc-ts-goodix-cap.idc \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/idc/tcc-ts-sitronix.idc:system/usr/idc/tcc-ts-sitronix.idc

#usr/keychars/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keychars/Generic.kcm:system/usr/keychars/Generic.kcm \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keychars/qwerty.kcm:system/usr/keychars/qwerty.kcm \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keychars/qwerty2.kcm:system/usr/keychars/qwerty2.kcm \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keychars/Virtual.kcm:system/usr/keychars/Virtual.kcm

#usr/keylayout/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keylayout/Generic.kl:system/usr/keylayout/Generic.kl \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl

#usr/share/zoneinfo/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/share/zoneinfo/zoneinfo.dat:system/usr/share/zoneinfo/zoneinfo.dat \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/share/zoneinfo/zoneinfo.idx:system/usr/share/zoneinfo/zoneinfo.idx \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/share/zoneinfo/zoneinfo.version:system/usr/share/zoneinfo/zoneinfo.version

#usr/srec/config/en.us/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/baseline.par:system/usr/srec/config/en.us/baseline.par \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/baseline8k.par:system/usr/srec/config/en.us/baseline8k.par \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/baseline11k.par:system/usr/srec/config/en.us/baseline11k.par

#usr/srec/config/en.us/dictionary/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/dictionary/basic.ok:system/usr/srec/config/en.us/dictionary/basic.ok \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/dictionary/cmu6plus.ok.zip:system/usr/srec/config/en.us/dictionary/cmu6plus.ok.zip \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/dictionary/enroll.ok:system/usr/srec/config/en.us/dictionary/enroll.ok

#usr/srec/config/en.us/g2p/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/g2p/en-US-ttp.data:system/usr/srec/config/en.us/g2p/en-US-ttp.data

#usr/srec/config/en.us/grammars/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/grammars/boolean.g2g:system/usr/srec/config/en.us/grammars/boolean.g2g \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/grammars/phone_type_choice.g2g:system/usr/srec/config/en.us/grammars/phone_type_choice.g2g \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/grammars/VoiceDialer.g2g:system/usr/srec/config/en.us/grammars/VoiceDialer.g2g

#usr/srec/config/en.us/models/
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic.swiarb:system/usr/srec/config/en.us/models/generic.swiarb \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic8.lda:system/usr/srec/config/en.us/models/generic8.lda \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic8_f.swimdl:system/usr/srec/config/en.us/models/generic8_f.swimdl \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic8_m.swimdl:system/usr/srec/config/en.us/models/generic8_m.swimdl \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic11.lda:system/usr/srec/config/en.us/models/generic11.lda \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic11_f.swimdl:system/usr/srec/config/en.us/models/generic11_f.swimdl \\
device/__MANUFACTURER__/__DEVICE__/proprietary/usr/srec/config/en.us/models/generic11_m.swimdl:system/usr/srec/config/en.us/models/generic11_m.swimdl

PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libMali.so:system/vendor/lib/libMali.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libstagefrighthw.so:system/vendor/lib/libstagefrighthw.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libTCC_CDK_AUDIO.so:system/vendor/lib/libTCC_CDK_AUDIO.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libTCC_CDK_LIB.so:system/vendor/lib/libTCC_CDK_LIB.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libTCC_CDK_WRAPPER.so:system/vendor/lib/libTCC_CDK_WRAPPER.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libTCCInterSubtitle.so:system/vendor/lib/libTCCInterSubtitle.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libTCCsubtitle.so:system/vendor/lib/libTCCsubtitle.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/libUMP.so:system/vendor/lib/libUMP.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/egl/libEGL_mali.so:system/vendor/lib/libEGL_mali.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/egl/libGLESv1_CM_mali.so:system/vendor/lib/egl/libGLESv1_CM_mali.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/egl/libGLESv2_mali.so:system/vendor/lib/egl/libGLESv2_mali.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/hw/gralloc.tcc892x.so:system/vendor/lib/hw/gralloc.tcc892x.so \\
device/__MANUFACTURER__/__DEVICE__/proprietary/vendor/lib/hw/hwcomposer.tcc892x.so:system/vendor/lib/hw/hwcomposer.tcc892x.so

#wifi:
PRODUCT_COPY_FILES += \\
device/__MANUFACTURER__/__DEVICE__/proprietary/wifi/wlan.ko:system/wifi/wlan.ko
EOF

./setup-makefiles.sh
