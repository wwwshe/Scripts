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

# tuist generate & pod init & update
echo "tuist generate" >> /tmp/tmp.sh

chmod +x /tmp/tmp.sh
open -a Terminal /tmp/tmp.sh
