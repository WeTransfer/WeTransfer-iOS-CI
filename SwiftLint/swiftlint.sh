#!/bin/bash
if [ -z "$CI" ]; then
    set -e

    BASEDIR=$(dirname "$0") # Sets the folder to WeTransfer-iOS-CI/SwiftLint/
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
        xcrun --sdk macosx mint run SwiftLint lint --use-script-input-files --config "$BASEDIR/.swiftlint-source.yml" --force-exclude || true;
        xcrun --sdk macosx mint run SwiftLint lint --use-script-input-files --config "$BASEDIR/.swiftlint-tests.yml" --force-exclude || true; # Don't fail if there's no tests to lint
    else
        echo "No files to lint, the number of files found is $count"
        exit 0
    fi
fi
