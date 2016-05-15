#!/bin/bash

cd haproxy
docker build -t gangtetris/haproxy:1.6 .
docker run --rm --name haproxy --link s1:s1 -p 80:80 -e SERVERS="s1" \
       gangtetris/haproxy:1.6
cd -

curl localhost:80/Anonymous

