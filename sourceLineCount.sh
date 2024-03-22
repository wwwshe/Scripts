#!/bin/sh

# swift 라인 수
find . -path ./Pods -prune -o -name "*.swift" -print0 ! -name "/Pods" | xargs -0 wc -l

# 오브젝티브c + Swift 프로젝트 라인 수
find . -type d ( -path ./Pods -o -path ./Vendor ) -prune -o ( -iname *.m -o -iname *.mm -o -iname *.h -o -iname *.swift ) -print0 | xargs -0 wc -l
