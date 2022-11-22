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