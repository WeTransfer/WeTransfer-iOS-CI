# We can have both HTTPS and SSH urls.
# HTTPS: https://github.com/WeTransfer/WeTransfer-iOS-CI.git
# SSH: git@github.com:WeTransfer/Mule.git
#
# Given the difference in URLs, the shared component is the last one (e.g. Mule.git).
# It's first needed to reverse the URL, split it by `.` and get the second part of it (the -f2 in `cut`),
# enabling to equate the URL split:
#   - URL: https://github.com/WeTransfer/WeTransfer-iOS-CI.git
#   - Reversed: tig.IC-SOi-refsnarTeW/refsnarTeW/moc.buhtig//:sptth
#   - Sectioned: [1: tig].[2: IC-SOi-refsnarTeW/refsnarTeW/moc].[3: buhtig//:sptth]
# The previous split is the input to the next one, this time by `/`, and then the first element is used (the -f1 in `cut`).
#   - Input: IC-SOi-refsnarTeW/refsnarTeW/moc
#   - Sectioned: [1: IC-SOi-refsnarTeW]/[2: refsnarTeW]/[3: moc]
# And lastly, we revert the result one more time, as the result will be reversed otherwise.
REPOSITORY_NAME=$(echo ${GIT_REPOSITORY_URL} | rev | cut -d '.' -f2 | cut -d '/' -f1 | rev)
ISSUE_URL="https://api.github.com/repos/${BITRISEIO_GIT_REPOSITORY_OWNER}/${REPOSITORY_NAME}/issues/${BITRISE_PULL_REQUEST}"
HEADER="Accept: application/vnd.github.v3+json"

PR_ASSIGNESS=$(
  curl \
    -s \
    -u ${GITBUDDY_ACCESS_TOKEN} \
    -H ${HEADER} \
    ${ISSUE_URL} \
    | jq -r '.assignees[] | .login'
)

if [ -z ${PR_ASSIGNESS} ]; then
  echo "PR assignees is empty. Continuing..."
else
  echo "PR assignees is not empty: ${PR_ASSIGNESS}. Nothing to do here..."
  exit 0
fi

PR_AUTHOR=$(
  curl \
    -s \
    -u ${GITBUDDY_ACCESS_TOKEN} \
    -H ${HEADER} \
    ${ISSUE_URL} \
    | jq -r .user.login
)

curl \
  -s \
  -u ${GITBUDDY_ACCESS_TOKEN} \
  -X POST \
  -H ${HEADER} \
  ${ISSUE_URL}/assignees \
  -d '{"assignees":["'${PR_AUTHOR}'"]}' \
  &> /dev/null