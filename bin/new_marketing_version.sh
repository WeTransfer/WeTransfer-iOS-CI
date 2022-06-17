#!/bin/bash

if [ -z "${NEW_VERSION}" ]; then
    echo "New version not provided. Cancelling workflow..."
    exit 1
fi

BRANCH_NAME="build/new-version/${NEW_VERSION}"
git checkout -b ${BRANCH_NAME}

CURRENT_VERSION=$(sed -n "/MARKETING_VERSION/{s/MARKETING_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}" ./Transfer.xcodeproj/project.pbxproj)

sed -i "" -e "s/MARKETING_VERSION \= [^\;]*\;/MARKETING_VERSION = ${NEW_VERSION};/" ./Transfer.xcodeproj/project.pbxproj

NEW_VERSION_TEXT="Update marketing version to \`${NEW_VERSION}\`"
git commit -am "${NEW_VERSION_TEXT}"

git push -u origin "${BRANCH_NAME}" --force

if ! [ $? -eq 0 ]; then
    echo "Pushing ${BRANCH_NAME} to the repo failed."
    exit 1
fi

# For more info on how the repository name is parsed, please refer to `Assign PR author`
REPOSITORY_NAME=$(echo ${GIT_REPOSITORY_URL} | rev | cut -d '.' -f2 | cut -d '/' -f1 | rev)

curl \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${DANGER_GITHUB_API_TOKEN}" \
    https://api.github.com/repos/${BITRISEIO_GIT_REPOSITORY_OWNER}/${REPOSITORY_NAME}/pulls \
    -d "{\"title\":\"${NEW_VERSION_TEXT}\",\"body\": \"Updated from \`${CURRENT_VERSION}\` to \`${NEW_VERSION}\`\",\"head\":\"${BRANCH_NAME}\",\"base\":\"develop\"}" \
    &> /dev/null

if ! [ $? -eq 0 ]; then
    echo "Pull request creation for ${BRANCH_NAME} failed. Deleting the branch..."

    git push origin --delete ${BRANCH_NAME}

    exit 1
fi
