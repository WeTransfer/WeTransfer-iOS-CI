app="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $app/setup_environment.sh

PR_LABELS=$(
  curl \
    -s \
    -u ${GITBUDDY_ACCESS_TOKEN} \
    -H ${HEADER} \
    ${ISSUE_URL} \
    | jq -r '.labels[] | .name'
)

echo "PR labels are: ${PR_LABELS}"

if [[ "$PR_LABELS" == *"ci-testing"* ]]; then
  echo "This PR is configured for testing CI."
  envman add --key CI_TESTING --value "true"
else
  echo "This PR is not configured for testing CI and runs as normal."
  envman add --key CI_TESTING --value "false"
fi