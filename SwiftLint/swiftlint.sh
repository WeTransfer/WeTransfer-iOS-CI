if [ -z "$CI" ]; then
	set -e
	
    if which swiftlint >/dev/null; then
    	BASEDIR=$(dirname "$0")
        swiftlint --config "$BASEDIR/.swiftlint-source.yml"
        swiftlint --config "$BASEDIR/.swiftlint-tests.yml" || true # Don't fail if there's no tests to lint
    else
    	echo "error: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
fi