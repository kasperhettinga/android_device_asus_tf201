# Copyright (C) 2011 The Android Open Source Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/asus/tf201/tf201-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/asus/tf201/overlay

# Prebuilt kernel location
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/asus/tf201/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Files needed for boot/recovery image
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \
    $(LOCAL_PATH)/ramdisk/init.cardhu.rc:root/init.cardhu.rc\
    $(LOCAL_PATH)/ramdisk/ueventd.cardhu.rc:root/ueventd.cardhu.rc \
    $(LOCAL_PATH)/ramdisk/init.cardhu.usb.rc:root/init.cardhu.usb.rc \
    $(LOCAL_PATH)/ramdisk/init.cardhu.cpu.rc:root/init.cardhu.cpu.rc \
    $(LOCAL_PATH)/ramdisk/fstab.cardhu:root/fstab.cardhu \
    $(LOCAL_PATH)/recovery/init.recovery.cardhu.rc:root/init.recovery.cardhu.rc


# Prebuilt configeration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/cpu.sh:system/bin/cpu.sh \
    $(LOCAL_PATH)/prebuilt/gpsconfig.xml:system/etc/gps/gpsconfig.xml \
    $(LOCAL_PATH)/prebuilt/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Input device configeration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/atmel-maxtouch.idc:system/usr/idc/atmel-maxtouch.idc \
    $(LOCAL_PATH)/idc/elantech_touchscreen.idc:system/usr/idc/elantech_touchscreen.idc \
    $(LOCAL_PATH)/idc/panjit_touch.idc:system/usr/idc/panjit_touch.idc \
    $(LOCAL_PATH)/prebuilt/asusdec.kcm:system/usr/keychars/asusdec.kcm \
    $(LOCAL_PATH)/prebuilt/asusdec.kl:system/usr/keylayout/asusdec.kl \
    $(LOCAL_PATH)/prebuilt/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/prebuilt/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl


# Camera/WiFi/BT Firmware
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/nvram_4329.txt:system/etc/nvram_nh615.txt \
    $(LOCAL_PATH)/prebuilt/nvram_4329.txt:system/etc/nvram_4329.txt \
    $(LOCAL_PATH)/prebuilt/firmware/BCM4329B1_002.002.023.0797.0863.hcd:system/etc/firmware/BCM4329B1_002.002.023.0797.0863.hcd

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    $(LOCAL_PATH)/asusdec/com.cyanogenmod.asusdec.xml:system/etc/permissions/com.cyanogenmod.asusdec.xml

# Build characteristics setting 
PRODUCT_CHARACTERISTICS := tablet

# This device have enough room for precise davick
PRODUCT_TAGS += dalvik.gc.type-precise

# Extra packages to build for this device
PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    make_ext4fs \
    setup_fs \
    audio.a2dp.default \
    audio.usb.default \
    libaudioutils \
    libinvensense_mpl \
    AutoParts_tfp \
    blobpack_tfp \
    mischelp \
    tinymix \
    tinyplay \
    tinyrec \
    com.cyanogenmod.asusdec \
    libasusdec_jni

# Build Some Extra Apps
PRODUCT_PACKAGES += \
    Torch

# Propertys spacific for this device
PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.opengles.version=131072 \
    persist.sys.usb.config=mtp,adb \
    ro.sf.lcd_density=160 \
    ro.zygote.disable_gl_preload=true \
    ro.bq.gpu_to_cpu_unsupported=1

# Tegra 3 spacific overrides
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.nvmmlite=1 \
    tf.enable=y

# Prime spacific overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.epad.model=TF201 \
    ro.epad.model_id=00 \
    ro.product.model=TF201 \

# media config xml file
PRODUCT_COPY_FILES += \
    device/asus/tf201/media_profiles.xml:system/etc/media_profiles.xml

# media codec config xml file
PRODUCT_COPY_FILES += \
    device/asus/tf201/media_codecs.xml:system/etc/media_codecs.xml

# audio policy configuration
PRODUCT_COPY_FILES += \
    device/asus/tf201/audio_policy.conf:system/etc/audio_policy.conf

# Inherit tablet dalvik settings
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

# Call the vendor to setup propiatory files
$(call inherit-product-if-exists, vendor/asus/tf201/tf201-vendor.mk)

# Copy bcm4329 firmware
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# Device nameing
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := tf201
PRODUCT_DEVICE := tf201
PRODUCT_MODEL := tf201
PRODUCT_BRAND := asus
PRODUCT_MANUFACTURER := asus
