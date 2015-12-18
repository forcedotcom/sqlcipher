#!/bin/sh

# Build for iOS
xcodebuild ARCHS="armv7 armv7s arm64" ONLY_ACTIVE_ARCH=NO -configuration Release -project sqlcipher.xcodeproj
xcodebuild ARCHS="x86_64 i386" ONLY_ACTIVE_ARCH=NO -configuration Release -project sqlcipher.xcodeproj -sdk iphonesimulator
lipo -create build/Release-iphoneos/libsqlcipher.a build/Release-iphonesimulator/libsqlcipher.a -output libsqlcipher.a

# Build for tvOS
xcodebuild ARCHS="arm64" ONLY_ACTIVE_ARCH=NO -sdk appletvos -configuration Release -project sqlcipher.xcodeproj
xcodebuild ARCHS="x86_64" ONLY_ACTIVE_ARCH=NO -configuration Release -project sqlcipher.xcodeproj -sdk appletvsimulator
lipo -create build/Release-appletvos/libsqlcipher.a build/Release-appletvsimulator/libsqlcipher.a -output libsqlcipher-tvos.a
