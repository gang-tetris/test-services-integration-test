if [ -z "$2" ]
then
    echo "Usage: $0 REPOSITORY_PATH CONTAINER [COMMIT=HEAD]"
    echo "  - REPOSITORY_PATH         name of organization/user and repository"
    echo "                            split by slash"
    echo "  - CONTAINER               name of container to build"
    echo "  - COMMIT                  hash of commit to build (default is HEAD)"
fi

REPOSITORY_PATH=$1
CONTAINER=$2
COMMIT="${3:-HEAD}"

mkdir -p "/tmp/${REPOSITORY_PATH}"
git clone "https://github.com/${REPOSITORY_PATH}.git" "/tmp/${REPOSITORY_PATH}/"
cd "/tmp/${REPOSITORY_PATH}"
git reset --hard ${COMMIT}
sudo docker build -t ${CONTAINER} .

