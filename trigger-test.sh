if [ -z "$2" ]
then
    echo "Usage: $0 ORGANIZATION REPOSITORY"
    echo "  - ORGANIZATION organization or username"
    echo "  - REPOSITORY   repository name"
    exit 1
fi
    
curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Travis-API-Version: 3" \
    -H "Athorization: token ${GIT_TOKEN}" \
    -d @body.json \
    https://api.travis-ci.org/repo/$1%2F$2/requests

