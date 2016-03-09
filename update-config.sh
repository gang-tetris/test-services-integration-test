if [ -z "$4" ]
then
    echo "Usage: $0 ORGANIZATION REPOSITORY FILEPATH CONTENT [MESSAGE]"
    echo "  - ORGANIZATION organization or username"
    echo "  - REPOSITORY   repository name"
    echo "  - FILEPATH     path of file within repository"
    echo "  - CONTENT      file content in base64 format"
    echo "  - MESSAGE      commit message (default is 'Config updated')"
    exit 1
fi

ORGANIZATION="$1"
REPOSITORY="$2"
PATH="$3"
CONTENT="$4"
MESSAGE="${5:-Config updated}"

URL="https://api.github.com/repos/${ORGANIZATION}/${REPOSITORY}/contents/${PATH}"

SHA=$(curl -s -X GET "${URL}" \
    -H "Authorization: token ${GIT_CONFIG_UPDATE_TOKEN}" | \
    grep '"sha":' | \
    sed 's/.*\([[:xdigit:]]\{40\}\).*/\1/g')

BODY=$(sed "s/SHA/${SHA}/g;s/CONTENT/${CONTENT}/g;s/MESSAGE/${MESSAGE}/g;" \
            config-update.json)

curl -s -X PUT "${URL}" \
    -H "Authorization: token ${GIT_CONFIG_UPDATE_TOKEN}" \
    -d "${BODY}"

