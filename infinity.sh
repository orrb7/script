#!/bin/bash
rm -rf prebuilts/clang/host/linux-x86
rm -rf device/advan
rm -rf vendor/advan
rm -rf out

repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh || repo sync

git clone --depth=1 https://github.com/orrb7/android_device_advan_X1.git -b infinity device/advan/X1
git clone --depth=1 https://github.com/G100-X1/android_vendor_advan_X1.git -b lineage-23.2 vendor/advan/X1
git clone --depth=1 https://github.com/G100-X1/android_device_advan_X1-kernel.git -b lineage-23.1 device/advan/X1-kernel

git clone https://github.com/G100-X1/device_mediatek_sepolicy_vndr.git -b lineage-23.1 device/mediatek/sepolicy_vndr
git clone https://github.com/G100-X1/hardware_mediatek.git -b lineage-23.1 hardware/mediatek
git clone https://github.com/G100-X1/android_vendor_mediatek_ims.git -b lineage-23.1 vendor/mediatek/ims
git clone https://github.com/G100-X1/android_vendor_sony_dolby.git -b sixteen-redesign vendor/sony/dolby

export BUILD_USERNAME=Rizj
export BUILD_HOSTNAME=DooPrjkt

repo sync

. build/envsetup.sh
lunch infinity_X1-user
m bacon -j$(nproc --all)
