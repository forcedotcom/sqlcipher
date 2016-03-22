#!/bin/sh
xcodebuild ARCHS="armv7 armv7s arm64" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphoneos -configuration Release -project sqlcipher.xcodeproj -target sqlcipher clean install
xcodebuild ARCHS="x86_64 i386" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphonesimulator -configuration Release -sdk iphonesimulator -project sqlcipher.xcodeproj -target sqlcipher clean install
lipo -create build/UninstalledProducts/iphoneos/libsqlcipher.a build/UninstalledProducts/iphonesimulator/libsqlcipher.a -output libsqlcipher.a
