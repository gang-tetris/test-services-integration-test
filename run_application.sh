#!/bin/bash

docker run -d --name repository \
    --link rabbit:rabbit --link cassandra:cassandra --link hazelcast:hazelcast \
    gangtetris/test-cassandra-repository
docker run -d --name logic \
    --link rabbit:rabbit \
    gangtetris/test-amqp-server

docker run -d --name rest -h rest \
    --link rabbit:rabbit \
    gangtetris/test-amqp-client
docker run -d --name haproxy \
    --link rest:rest -e SERVERS="rest" \
    -p 80:80 \
    gangtetris/haproxy:1.6

