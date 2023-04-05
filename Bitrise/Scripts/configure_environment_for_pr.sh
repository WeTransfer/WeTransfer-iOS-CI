app="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $app/setup_environment.sh

PR_LABELS=$(
  curl \
    -s \
    -u ${GITBUDDY_ACCESS_TOKEN} \
    -H "${HEADER}" \
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

if [[ "$PR_LABELS" == *"create-simulator-build"* ]]; then
  echo "This PR is going to deliver a Simulator Build inside the Danger message."
  envman add --key CREATE_SIMULATOR_BUILD --value "true"
else
  echo "This PR is not going to deliver a Simulator Build inside the Danger message."
  envman add --key CREATE_SIMULATOR_BUILD --value "false"
fi

CHANGED_FILES=$(
  curl -s -u ${GITBUDDY_ACCESS_TOKEN} -H "${HEADER}" ${PULL_FILES_URL} | jq -r '.[].filename'
)

if echo "$CHANGED_FILES" | grep -q "\.swift$"; then
  echo "The PR contains '.swift' files, let's test and run Danger"
  envman add --key SKIP_TESTS_AND_DANGER --value "false"
else
  echo "The PR does not contain '.swift' files, let's skip tests and Danger"
  envman add --key SKIP_TESTS_AND_DANGER --value "true"
fi