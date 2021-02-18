#!/bin/bash
echo "Starting Hazelcast"
clear
cd /usr/local/bin
wget -4 https://oss.sonatype.org/content/repositories/snapshots/com/hazelcast/hazelcast-distribution/5.0-SNAPSHOT/hazelcast-distribution-5.0-20210218.161733-6.tar.gz
tar zxvf hazelcast-distribution-5.0-20210218.161733-6.tar.gz
rm hazelcast-distribution-5.0-20210218.161733-6.tar.gz
cd hazelcast-5.0-SNAPSHOT/bin
chmod +x hazelcast-start
chmod +x hazelcast
chmod +x hazelcast-stop
chmod +x common.sh
mkdir csv-dir
printf "id,name,like\n" >> csv-dir/likes.csv
printf "1,Jerry,13\n" >> csv-dir/likes.csv
printf "2,Greg,108\n" >> csv-dir/likes.csv
printf "3,Mary,73\n" >> csv-dir/likes.csv
printf "4,Jerry,88\n" >> csv-dir/likes.csv
./hazelcast-start