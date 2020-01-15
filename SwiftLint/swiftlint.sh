if [ -z "$CI" ]; then
    if which swiftlint >/dev/null; then
    	BASEDIR=$(dirname "$0")
        swiftlint --config "$BASEDIR/.swiftlint-source.yml"
        swiftlint --config "$BASEDIR/.swiftlint-tests.yml"
    else
    	echo "error: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
fi