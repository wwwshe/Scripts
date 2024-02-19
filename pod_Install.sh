#!/bin/sh

# move project dir
PROJECT_HOME=`pwd`
echo "cd $PROJECT_HOME" > /tmp/tmp.sh

# search .xcodeproj file and strip filename
PROJECT_NAME=""
for f in *.xcodeproj; do
    PROJECT_NAME="${f%.*}"
    break
done

if [[ -z "$PROJECT_NAME" ]] || [ "$PROJECT_NAME" == "*" ]; then
    osascript -e 'error'
    exit
fi

# pod init & update
echo "pod init;pod install;clear;" >> /tmp/tmp.sh

# reload workspace file
echo "wait" >> /tmp/tmp.sh
echo "echo \"Close '$PROJECT_NAME' Xcode window\""  >> /tmp/tmp.sh
echo "open $PROJECT_NAME.xcworkspace" >> /tmp/tmp.sh
echo "rm /tmp/tmp.sh" >> /tmp/tmp.sh

chmod +x /tmp/tmp.sh
open -a Terminal /tmp/tmp.sh
