#!/bin/bash
echo "Starting Hazelcast"
docker network create hazelcast-network
mkdir csv-dir
printf "id,name,likes\n" >> csv-dir/likes.csv
printf "1,Jerry,13\n" >> csv-dir/likes.csv
printf "2,Greg,108\n" >> csv-dir/likes.csv
printf "3,Mary,73\n" >> csv-dir/likes.csv
printf "4,Jerry,88\n" >> csv-dir/likes.csv
docker run \
  -it \
  -v "$(pwd)"/csv-dir:/csv-dir \
  --network hazelcast-network \
  --rm \
  -e HZ_CLUSTERNAME=hello-world \
  -p 5701:5701 hazelcast/hazelcast:5.0-SNAPSHOT