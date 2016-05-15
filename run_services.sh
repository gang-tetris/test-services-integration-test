docker run -d --name cassandra -h cassandra gangtetris/cassandra:2.2
docker run -d --name hazelcast -h hazelcast -p 5701 gangtetris/hazelcast:3.6
docker run -d --name rabbit -h rabbit rabbitmq:3

until docker exec cassandra cqlsh -e quit
do
    sleep 1
done

REPOSITORY_PATH="gang-tetris/test-cassandra-repository"
if [ ! -d "/tmp/${REPOSITORY_PATH}" ]
then
    mkdir -p "/tmp/${REPOSITORY_PATH}"
    git clone "https://github.com/${REPOSITORY_PATH}.git" "/tmp/${REPOSITORY_PATH}/"
fi
cd "/tmp/${REPOSITORY_PATH}"
exec "/tmp/${REPOSITORY_PATH}/run_migrations.sh"
cd -

until docker exec -it rabbit rabbitctl status
do
    sleep 1
done

HAZELCAST_URL="http://0.0.0.0:5701/hazelcast/rest/management/cluster/state"
until curl --data "app1&app1-pass" "${HAZELCAST_URL}"
do
    sleep 1
done

