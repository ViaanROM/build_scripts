#! /bin/bash

rm -rf .repo/local_manifests; \
rm -rf {device,vendor,kernel,hardware}/oneplus && \
rm -rf prebuilts/clang/host/linux-x86 && \
repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault && \
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) && \
git clone https://github.com/anshedu/android_device_oneplus_larry -b Infinity15 device/oneplus/larry && \
git clone https://github.com/anshedu/android_device_oneplus_sm6375-common -b lineage-22.2 device/oneplus/sm6375-common && \
git clone https://github.com/anshedu/proprietary_vendor_oneplus_larry -b lineage-22.2 vendor/oneplus/larry && \
git clone https://github.com/anshedu/proprietary_vendor_oneplus_sm6375-common -b lineage-22.2 vendor/oneplus/sm6375-common && \
git clone https://github.com/anshedu/android_kernel_oneplus_sm6375 -b lineage-22.2 kernel/oneplus/sm6375 && \
git clone https://github.com/anshedu/android_hardware_oplus -b lineage-22.2 hardware/oplus && \
# Vanilla Build
. build/envsetup.sh && \
lunch infinity_larry-user && make installclean && mka bacon; \
rm -rf out/target/product/vanilla && rm -rf out/target/product/gapps; \
cd out/target/product && mv larry vanilla && cd ../../..; \
# Gapps Build
cd device/oneplus/larry && rm infinity_larry.mk && mv gapps.txt infinity_larry.mk && cd ../../..; \
. build/envsetup.sh; \
lunch infinity_larry-user && make installclean && mka bacon; \
cd out/target/product && mv larry gapps && cd ../../..; \
