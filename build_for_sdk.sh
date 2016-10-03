#!/bin/sh
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode" ARCHS="armv7 armv7s arm64" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphoneos -configuration Release -project sqlcipher.xcodeproj -target sqlcipher clean install
if [ -f "build/UninstalledProducts/libsqlcipher.a" ]; then
	mkdir -p build/UninstalledProducts/iphoneos
	mv build/UninstalledProducts/libsqlcipher.a build/UninstalledProducts/iphoneos/libsqlcipher.a
fi
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode" ARCHS="x86_64 i386" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphonesimulator -configuration Release -sdk iphonesimulator -project sqlcipher.xcodeproj -target sqlcipher clean install
if [ -f "build/UninstalledProducts/libsqlcipher.a" ]; then
	mkdir -p build/UninstalledProducts/iphonesimulator
	mv build/UninstalledProducts/libsqlcipher.a build/UninstalledProducts/iphonesimulator/libsqlcipher.a
fi
lipo -create build/UninstalledProducts/iphoneos/libsqlcipher.a build/UninstalledProducts/iphonesimulator/libsqlcipher.a -output libsqlcipher.a
