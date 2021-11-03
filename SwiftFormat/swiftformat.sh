if [ -z "$CI" ]; then
    BASEDIR=$(dirname "$0")
    xcrun --sdk macosx mint run SwiftFormat  --config "$BASEDIR/.swiftformat" .
fi