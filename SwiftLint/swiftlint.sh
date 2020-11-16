#!/bin/bash
if [ -z "$CI" ]; then
	set -e
	
    if which swiftlint >/dev/null; then
    	BASEDIR=$(dirname "$0")
    	count=0

	    for file_path in $(git ls-files -m --exclude-from=.gitignore | grep ".swift$"); do
	        export SCRIPT_INPUT_FILE_$count=$file_path
	        count=$((count + 1))
	    done

	    for file_path in $(git diff --name-only --cached | grep ".swift$"); do
	        export SCRIPT_INPUT_FILE_$count=$file_path
	        count=$((count + 1))
	    done

		export SCRIPT_INPUT_FILE_COUNT=$count

		if [ "$count" -ne 0 ]; then
	        echo "Found lintable files! Linting..."
	        swiftlint lint --use-script-input-files --config "$BASEDIR/.swiftlint-source.yml" --force-exclude;
		    swiftlint lint --use-script-input-files --config "$BASEDIR/.swiftlint-tests.yml" --force-exclude || true; # Don't fail if there's no tests to lint
	    else
	        echo "No files to lint!"
	        exit 0
	    fi
    else
    	echo "error: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
fi