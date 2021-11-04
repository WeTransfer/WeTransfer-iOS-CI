#!/bin/bash
if [[ $(uname -p) == 'arm' ]]; then
    export PATH="$PATH:/opt/homebrew/bin"
fi

if [ -z "$CI" ]; then
    BASEDIR=$(dirname "$0")
    xcrun --sdk macosx mint run -m "$BASEDIR/Mintfile" SwiftFormat --config "$BASEDIR/.swiftformat" .
fi