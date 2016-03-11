if [ -z "$4" ]
then
    echo "Usage: $0 REPOSITORY_PATH PROJECT"
    echo "  - REPOSITORY_PATH         name of organization/user and repository"
    echo "                            split by slash"
    echo "  - PROJECT                 name of the project being configured"
    exit 1
fi

REPOSITORY_PATH="$1"
PROJECT="$2"

FILEPATH="${PROJECT}-config.sh"
VARS_PREFIX=$(tr '[:lower:]-' '[:upper:]_' ${PROJECT})

CONTENT=$(base64 <(echo "export ${VARS_PREFIX}=\"${TRAVIS_COMMIT}\"") -w 0)
COMMIT_DESCRIPTION="Changes ${TRAVIS_COMMIT_RANGE} in ${PROJECT}"
COMMIT_TITLE="Triggering tests"
MESSAGE="${COMMIT_TITLE}\\\n\\\n${COMMIT_DESCRIPTION}"

URL="https://api.github.com/repos/${REPOSITORY_PATH}/contents/${FILEPATH}"

SHA=$(curl -s -X GET "${URL}" \
    -H "Authorization: token ${GIT_CONFIG_UPDATE_TOKEN}" | \
    grep '"sha":' | \
    sed 's/.*\([[:xdigit:]]\{40\}\).*/\1/g')

BODY=$(sed "s/SHA/${SHA}/g;s/CONTENT/${CONTENT}/g;s/MESSAGE/${MESSAGE}/g;" \
            config-update.json)

curl -s -X PUT "${URL}" \
    -H "Authorization: token ${GIT_CONFIG_UPDATE_TOKEN}" \
    -d "${BODY}" > /dev/null

