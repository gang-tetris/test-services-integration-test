echo "Upgrade Docker Engine"
sudo apt-get update
sudo cp /etc/default/docker /tmp/docker.config
sudo apt-get purge docker-engine -y
sudo apt-get install docker-engine -y
sudo mv /tmp/docker.config /etc/default/docker
sudo service docker restart

echo "Upgrade Docker Compose to ${DOCKER_COMPOSE_VERSION}"
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose

