if [ -z "$5" ]
then
    echo "Usage: $0 ORGANIZATION REPOSITORY FILEPATH CONTENT SHA"
    echo "  - ORGANIZATION organization or username"
    echo "  - REPOSITORY   repository name"
    echo "  - FILEPATH     content path"
    echo "  - CONTENT      file content in base64 format"
    echo "  - SHA          blob sha of file being modified"
    exit 1
fi

CONTENT=$(cat config-update.json | sed "s/PATH/$3/g" | sed "s/CONTENT/$4/g" | sed "s/SHA/$5/g")

curl -s -X PUT \
    -H "Authorization: token ${GIT_CONFIG_UPDATE_TOKEN}" \
    -d "$CONTENT" \
    "https://api.github.com/repos/$1/$2/contents/$3"

