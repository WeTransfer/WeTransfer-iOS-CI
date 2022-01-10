#!/bin/bash
if [[ $(uname -p) == 'arm' ]]; then
    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
fi

if [ -z "$CI" ]; then
    set -e

    BASEDIR=$(dirname "$0") # Sets the folder to WeTransfer-iOS-CI/BuildTools/
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
        xcrun --sdk macosx mint run -m "$BASEDIR/Mintfile" SwiftLint lint --use-script-input-files --config "$BASEDIR/.swiftlint.yml" --force-exclude || true;
    else
        echo "No files to lint, the number of files found is $count"
        exit 0
    fi
fi