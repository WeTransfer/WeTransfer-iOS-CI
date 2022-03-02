#!/bin/bash

if [ -z "$CI" ]; then
    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
    BASEDIR=$(dirname "$0")
    xcrun --sdk macosx mint run -m "$BASEDIR/Mintfile" SwiftFormat --config "$BASEDIR/.swiftformat" .
fi
