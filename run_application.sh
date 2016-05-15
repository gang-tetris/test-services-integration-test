#!/bin/bash

docker run -d \
    --link rabbit:rabbit --link cassandra:cassandra --link hazelcast:hazelcast \
    gangtetris/test-cassandra-repository
docker run -d \
    --link rabbit:rabbit \
    gangtetris/test-amqp-server
docker run -d --name s1 -h s1 \
    --link rabbit:rabbit \
    gangtetris/test-amqp-client

