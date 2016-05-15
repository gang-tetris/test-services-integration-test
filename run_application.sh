#!/bin/bash

docker run -d --name repository \
    --link rabbit:rabbit --link cassandra:cassandra --link hazelcast:hazelcast \
    gangtetris/test-cassandra-repository
docker run -d --name logic \
    --link rabbit:rabbit \
    gangtetris/test-amqp-server
docker run -d --name s1 -h s1 \
    --link rabbit:rabbit \
    gangtetris/test-amqp-client

