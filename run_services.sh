docker run -d --name cassandra -h cassandra gangtetris/cassandra:2.2
docker run -d --name hazelcast -h hazelcast gangtetris/hazelcast:3.6
docker run -d --name rabbit -h rabbit rabbitmq:3

until docker exec cassandra cqlsh -e quit
do
    sleep 1
done

echo "Cassandra is up"

REPOSITORY_PATH="gang-tetris/test-cassandra-repository"
if [ ! -d "/tmp/${REPOSITORY_PATH}" ]
then
    mkdir -p "/tmp/${REPOSITORY_PATH}"
    git clone "https://github.com/${REPOSITORY_PATH}.git" "/tmp/${REPOSITORY_PATH}/"
fi
cd "/tmp/${REPOSITORY_PATH}"
bash run_migrations.sh
cd -

echo "Cassandra migrations applied"

until docker exec rabbit rabbitmqctl status
do
    sleep 1
done

echo "RabbitMQ is up"

HAZELCAST_URL="http://hazelcast:5701/hazelcast/rest/management/cluster/state"
until docker exec hazelcast curl --data "app1&app1-pass" "${HAZELCAST_URL}"
do
    sleep 1
done

echo "Hazelcast is up"

