#!/bin/bash
set -e
echo $IPA_OUTPUT_PATH
output=$(curl -u $BROWSERSTACK_USERNAME:$BROWSERSTACK_ACCESS_KEY \
-X POST "https://api-cloud.browserstack.com/app-automate/upload" \
-F "file=@$IPA_OUTPUT_PATH")
echo 'Curl done'
echo $output
