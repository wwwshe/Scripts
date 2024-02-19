#!/bin/sh

PROJECT_NAME=""

# 현재 프로젝트의 네임 가져오기
for f in *.xcodeproj; do
    PROJECT_NAME="${f%.*}"
    break
done

xcodebuild archive -scheme "$PROJECT_NAME" -archivePath "./build/xcarchive/ios.xcarchive" -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive -scheme "$PROJECT_NAME" -archivePath "./build/xcarchive/ios_sim.xcarchive" -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
-framework "./build/xcarchive/ios.xcarchive/Products/Library/Frameworks/"$PROJECT_NAME".framework" \
-framework "./build/xcarchive/ios_sim.xcarchive/Products/Library/Frameworks/"$PROJECT_NAME".framework" \
-output "./build/"$PROJECT_NAME".xcframework"

# xcarchive 폴더 삭제
if [ -d "build/xcarchive" ]; then
    rm -rf "build/xcarchive"
fi

