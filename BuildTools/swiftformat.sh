#!/bin/bash

if [ -z "$CI" ]; then
    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

    BASEDIR=$(dirname "$0")
    MINT_FILE_PATH=$BASEDIR/Mintfile
    SWIFT_FORMAT=SwiftFormat
    SWIFT_FORMAT_VERSION=$(grep -F $SWIFT_FORMAT $MINT_FILE_PATH)

    if ! xcrun --sdk macosx mint which -s $SWIFT_FORMAT_VERSION > /dev/null; then
        xcrun --sdk macosx mint bootstrap -m $MINT_FILE_PATH
    fi

    git diff --diff-filter=d --staged --name-only | grep -e '\(.*\).swift$' | while read file; do
        xcrun --sdk macosx mint run -m $MINT_FILE_PATH $SWIFT_FORMAT --config "$BASEDIR/.swiftformat" "${file}";
        git add "$file";
    done
fi
