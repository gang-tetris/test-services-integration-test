if [ -z "$2" ]
then
    echo "Usage: $0 ORGANIZATION/REPOSITORY CONTAINER [COMMIT=HEAD]"
    echo "  - ORGANIZATION/REPOSITORY name of organization or user and repository"
    echo "                            split by slash"
    echo "  - CONTAINER               name of container to build"
    echo "  - COMMIT                  hash of commit to build (default is HEAD)"
fi

ORGANIZATION=$1
CONTAINER=$2
COMMIT="${3:-HEAD}"

mkdir -p "/tmp/${ORGANIZATION}"
git clone "https://github.com/${ORGANIZATION}.git" "/tmp/${ORGANIZATION}/"
cd "/tmp/${ORGANIZATION}"
git reset --hard ${COMMIT}
sudo docker build -t ${CONTAINER} .

