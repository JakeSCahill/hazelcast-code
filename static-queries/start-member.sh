#!/bin/bash
echo "Starting Hazelcast"
clear
cd /usr/local/bin
wget -4 https://oss.sonatype.org/content/repositories/snapshots/com/hazelcast/hazelcast-distribution/5.0-SNAPSHOT/hazelcast-distribution-5.0-20210217.144925-5-slim.tar.gz
tar zxvf hazelcast-distribution-5.0-20210217.144925-5-slim.tar.gz
rm hazelcast-distribution-5.0-20210217.144925-5-slim.tar.tar.gz
cd hazelcast-5.0-SNAPSHOT-slim/bin
chmod +x hazelcast-start
chmod +x hazelcast
chmod +x hazelcast-stop
chmod +x common.sh
mkdir csv-dir
printf "id\tname\tlike\n" >> csv-dir/likes.csv
printf "1\tJerry\t13\n" >> csv-dir/likes.csv
printf "2\tGreg\t108\n" >> csv-dir/likes.csv
printf "3\tMary\t73\n" >> csv-dir/likes.csv
printf "4\tJerry\t88\n" >> csv-dir/likes.csv
./hazelcast-start