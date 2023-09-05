color="\033[0;32m"
end="\033[0m"

# Clone dependencies
echo -e "${color}Cloning dependencies...${end}"
# prebuilt apps
git clone --quiet https://github.com/Xiaomi-MT6768-Dev/prebuilt-apps --depth 1 xiaomi-mt6768-dev/packages/prebuilt-apps > /dev/null
# vendor
git clone --quiet https://github.com/Xiaomi-MT6768-Dev/proprietary_vendor_xiaomi --depth 1 vendor/xiaomi > /dev/null
# kernel
git clone https://github.com/Xiaomi-MT6768-Dev/kernel_xiaomi_mt6768 --depth 1 kernel/xiaomi/mt6768 > /dev/null
# mtk sepolicy vendor
rm -rf device/mediatek/sepolicy_vndr
git clone --quiet https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr --depth 1 device/mediatek/sepolicy_vndr > /dev/null
# mtk hardware 
rm -rf hardware/mediatek
git clone --quiet https://github.com/LineageOS/android_hardware_mediatek --depth 1 hardware/mediatek > /dev/null
# clang
git clone --quiet https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r487747c --depth 1 prebuilts/clang/host/linux-x86/clang-r487747c

echo -e "Dependencies cloned successfully!"

# Configure the patches path
patchDir="device/xiaomi/lancelot/patches"
echo -e "Patches Path: ${patchDir}"

echo -e "${color}Applying patches !${end}"

# Patch bootanimation lag
rm -rf frameworks/native/libs/renderengine/threaded/RenderEngineThreaded.cpp

cp ${patchDir}/frameworks/native/libs/renderengine/threaded/RenderEngineThreaded.cpp frameworks/native/libs/renderengine/threaded/

# Patch media codec issues
echo -e "Applying Media Codec patches!"
rm -rf frameworks/av/include/media/MediaExtractorPluginHelper.h
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/GenericSource.h
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/NuPlayerSource.h
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/GenericSource.cpp
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/NuPlayerDecoder.cpp
rm -rf frameworks/av/media/libstagefright/include/media/stagefright/ACodec.h
rm -rf frameworks/av/media/libstagefright/include/media/stagefright/MediaCodecSource.h
rm -rf frameworks/av/media/libstagefright/ACodec.cpp
rm -rf frameworks/av/media/libstagefright/MediaCodecSource.cpp
rm -rf frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp
rm -rf frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp
rm -rf frameworks/av/media/mediaserver/mediaserver.rc
rm -rf frameworks/av/media/extractors/ogg/OggExtractor.cpp
rm -rf frameworks/av/services/mediacodec/seccomp_policy/mediaswcodec-arm.policy
rm -rf frameworks/av/services/mediaextractor/mediaextractor.rc

cp ${patchDir}/frameworks/av/include/media/MediaExtractorPluginHelper.h frameworks/av/include/media/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/GenericSource.h frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/NuPlayerSource.h frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/GenericSource.cpp frameworks/av/media/libmediaplayerservice/nuplayer/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/NuPlayerDecoder.cpp frameworks/av/media/libmediaplayerservice/nuplayer/
cp ${patchDir}/frameworks/av/media/libstagefright/include/media/stagefright/ACodec.h frameworks/av/media/libstagefright/include/media/stagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/include/media/stagefright/MediaCodecSource.h frameworks/av/media/libstagefright/include/media/stagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/ACodec.cpp frameworks/av/media/libstagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/MediaCodecSource.cpp frameworks/av/media/libstagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp frameworks/av/media/libstagefright/omx/
cp ${patchDir}/frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp frameworks/av/media/libstagefright/omx/
cp ${patchDir}/frameworks/av/media/mediaserver/mediaserver.rc frameworks/av/media/mediaserver/
cp ${patchDir}/frameworks/av/media/extractors/ogg/OggExtractor.cpp frameworks/av/media/extractors/ogg/
cp ${patchDir}/frameworks/av/services/mediacodec/seccomp_policy/mediaswcodec-arm.policy frameworks/av/services/mediacodec/seccomp_policy/
cp ${patchDir}/frameworks/av/services/mediaextractor/mediaextractor.rc frameworks/av/services/mediaextractor/

echo -e "${color}Patch applied successfully!${end}"