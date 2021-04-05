#!/bin/sh
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode" ARCHS="arm64 arm64e" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphoneos -configuration Release -project sqlcipher.xcodeproj -target sqlcipher clean install
if [ -f "build/UninstalledProducts/iphoneos/libsqlcipher.a" ]; then
	mv build/UninstalledProducts/iphoneos/libsqlcipher.a libsqlcipher-iphoneos.a
fi
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode" ARCHS="x86_64" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphonesimulator -configuration Release -sdk iphonesimulator -project sqlcipher.xcodeproj -target sqlcipher clean install
if [ -f "./build/UninstalledProducts/iphonesimulator/libsqlcipher.a" ]; then
	mv ./build/UninstalledProducts/iphonesimulator/libsqlcipher.a libsqlcipher-iphonesimulator.a
fi

xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode" ONLY_ACTIVE_ARCH=NO -destination "generic/platform=macOS,variant=Mac Catalyst,name=Any Mac" -derivedDataPath "./build-catalyst" -configuration Release -project sqlcipher.xcodeproj -scheme sqlcipher clean build
if [ -f "./build-catalyst/Build/Products/Release-maccatalyst/libsqlcipher.a" ]; then
    mv build-catalyst/Build/Products/Release-maccatalyst/libsqlcipher.a libsqlcipher-catalyst.a
fi

xcodebuild -create-xcframework -output SQLCipher.xcframework \
    -library libsqlcipher-iphoneos.a \
    -library libsqlcipher-iphonesimulator.a \
    -library libsqlcipher-catalyst.a
