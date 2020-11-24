#!/bin/bash
if [ -z "$CI" ]; then
	set -e
	
    if which swiftlint >/dev/null; then
    	BASEDIR=$(dirname "$0")
    	count=0

    	# Unstaged files
		while read filename; do 
			export SCRIPT_INPUT_FILE_$count="${filename}"
			count=$((count + 1))
		done < <(git diff --relative --name-only $SRCROOT | grep ".swift$")

		# Staged files
		while read filename; do 
			export SCRIPT_INPUT_FILE_$count="${filename}"
			count=$((count + 1))
		done < <(git diff --relative --diff-filter=d --cached --name-only $SRCROOT | grep ".swift$")

		# Committed files
		while read filename; do 
			export SCRIPT_INPUT_FILE_$count="${filename}"
			count=$((count + 1))
		done < <(git diff develop... --relative --diff-filter=d --name-only $SRCROOT | grep ".swift$")

		export SCRIPT_INPUT_FILE_COUNT=$count

		if (( $count > 0 )); then
	        echo "Found lintable files! Linting..."
	        swiftlint lint --use-script-input-files --config "$BASEDIR/.swiftlint-source.yml" --force-exclude || true;
		    swiftlint lint --use-script-input-files --config "$BASEDIR/.swiftlint-tests.yml" --force-exclude || true; # Don't fail if there's no tests to lint
	    else
	        echo "No files to lint, the number of files found is $count"
	        exit 0
	    fi
    else
    	echo "error: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
fi
