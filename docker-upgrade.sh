echo "Upgrade Docker Engine"
apt-get update
cp /etc/default/docker /tmp/docker.config
apt-get purge docker-engine -y
apt-get install docker-engine -y
mv /tmp/docker.config /etc/default/docker
service docker restart

echo "Upgrade Docker Compose to ${DOCKER_COMPOSE_VERSION}"
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
mv docker-compose /usr/local/bin/docker-compose

