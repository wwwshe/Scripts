#!/bin/sh

PROJECT_NAME=""

# 현재 프로젝트의 네임 가져오기
for f in *.xcodeproj; do
    PROJECT_NAME="${f%.*}"
    break
done

# Output폴더 체크 없으면 종료
if ! [ -d "Output" ]; then
    echo "Error: Directory Output does not exists."
    exit 1
fi

# Output폴더의 ipa폴더 체크 없으면 생성
if ! [ -d "Output/ipa" ]; then
    mkdir "Output/ipa"
fi

# Output폴더의 xcarchive폴더 체크 없으면 생성
if ! [ -d "Output/xcarchive" ]; then
    mkdir "Output/xcarchive"
fi

# xcodebuild로 xcarchive 생성
xcodebuild -project "$PROJECT_NAME.xcodeproj" -scheme "$PROJECT_NAME" -archivePath Output/xcarchive/"$PROJECT_NAME".xcarchive archive -destination 'generic/platform=iOS'

# xcodebuild로 xcarchive를 ipa로 생성
xcodebuild -exportArchive -archivePath Output/xcarchive/"$PROJECT_NAME".xcarchive -exportPath Output/ipa -exportOptionsPlist ExportOptions/ExportOptions.plist

# testflight에 업로드 패스워드는 애플계정의 앱 암호
xcrun altool --upload-app --type ios --file Output/ipa/'$PROJECT_NAME'.ipa --username "이메일" --password "앱 패스워드"
