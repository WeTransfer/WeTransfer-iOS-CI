#!/bin/bash

if [ -z "$CI" ]; then
    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

    set -e

    BASEDIR=$(dirname "$0") # Sets the folder to WeTransfer-iOS-CI/BuildTools/

    MINT_FILE_PATH=$BASEDIR/Mintfile
    SWIFT_LINT=SwiftLint
    SWIFT_LINT_VERSION=$(grep -F $SWIFT_LINT $MINT_FILE_PATH)

    if ! xcrun --sdk macosx mint which -s $SWIFT_LINT_VERSION > /dev/null; then
      xcrun --sdk macosx mint bootstrap -m $MINT_FILE_PATH
    fi

    execution_directory="$(pwd)"
    count=0
    export SRCROOT="$(pwd)"

    printf "\nExecuting SwiftLint from ${execution_directory}\n"

    # Unstaged files
    while read filename; do
        export SCRIPT_INPUT_FILE_$count="${filename}"
        echo "Found '${filename}'"
        count=$((count + 1))
    done < <(git diff --relative --name-only $SRCROOT | grep ".swift$")

    # Staged files
    while read filename; do
        export SCRIPT_INPUT_FILE_$count="${filename}"
        echo "Found '${filename}'"
        count=$((count + 1))
    done < <(git diff --relative --diff-filter=d --cached --name-only $SRCROOT | grep ".swift$")

    # Committed files
    while read filename; do
        export SCRIPT_INPUT_FILE_$count="${filename}"
        echo "Found '${filename}'"
        count=$((count + 1))
    done < <(git diff develop... --relative --diff-filter=d --name-only $SRCROOT | grep ".swift$")

    export SCRIPT_INPUT_FILE_COUNT=$count

    if (( $count > 0 )); then
        echo "Found ${count} lintable files! Linting..."
        xcrun --sdk macosx mint run -m $MINT_FILE_PATH $SWIFT_LINT lint --use-script-input-files --config "$BASEDIR/.swiftlint.yml" --force-exclude || true;
    else
        echo "No files to lint, the number of files found is $count"
        exit 0
    fi
fi
