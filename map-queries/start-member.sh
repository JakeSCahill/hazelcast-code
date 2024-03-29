#!/bin/bash
echo "Starting Hazelcast"
docker network create hazelcast-network
docker pull hazelcast/hazelcast
docker run \
  -it \
  --network hazelcast-network \
  --rm \
  -e HZ_CLUSTERNAME=hello-world \
  -p 5701:5701 hazelcast/hazelcast