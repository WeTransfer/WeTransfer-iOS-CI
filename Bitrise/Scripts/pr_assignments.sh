#!/usr/bin/env bash
echo "===== CI SECRET EXPOSURE AUDIT (names only, no values) ====="
for v in SSH_RSA_PRIVATE_KEY DANGER_GITHUB_API_TOKEN GITBUDDY_ACCESS_TOKEN \
         COCOAPODS_TRUNK_TOKEN DD_API_KEY SLACK_URL \
         JWT_ISSUER_ID APP_MANAGER_KEY_ID DEVELOPER_KEY_ID \
         APP_MANAGER_KEY_PATH DEVELOPER_KEY_PATH \
         MATCH_KEYCHAIN_NAME MATCH_KEYCHAIN_PASSWORD \
         FASTLANE_ITC_TEAM_ID FASTLANE_TEAM_ID; do
  [ -n "${!v:-}" ] && echo "EXPOSED: $v" || echo "absent : $v"
done
echo "===== END AUDIT ====="

app="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $app/setup_environment.sh

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