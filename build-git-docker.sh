if [ -z "$2" ]
then
    echo "Usage: $0 ORGANIZATION/REPOSITORY CONTAINER"
    echo "  - ORGANIZATION/REPOSITORY name of organization or user and repository"
    echo "                            split by slash"
    echo "  - CONTAINER               name of container to build"
fi

mkdir -p /tmp/$1
git clone "https://github.com/${1}.git" /tmp/$1/
sudo docker build -t $2 /tmp/$1

