if [ -z "$2" ]
then
    echo "Usage: $0 REPOSITORY IMAGES ..."
    echo "  - REPOSITORY    name of Docker repository"
    echo "  - IMAGES        names of Docker images"
    exit 1
fi

REPOSITORY=$1
TOKEN_PREFIX="TOKEN_DOCKER"

shift
while test ${#} -gt 0
do
    IMAGE=$1
    TOKEN_ID=`echo ${IMAGE} | sed 's/-/_/g' | tr '[:lower:]' '[:upper:]'`
    TOKEN_NAME=${TOKEN_PREFIX}_${TOKEN_ID}
    eval TOKEN='$'$TOKEN_NAME

    IMAGE_URL="https://registry.hub.docker.com/u/${REPOSITORY}/${IMAGE}"
    curl -X POST \
        -H "Content-Type: application/json" \
        -d '{"build": true}' \
        "${IMAGE_URL}/trigger/${TOKEN}/" > /dev/null
    shift
done

