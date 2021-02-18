#!/bin/bash
echo "Starting Hazelcast"
clear
wget -4 https://oss.sonatype.org/content/repositories/snapshots/com/hazelcast/hazelcast-distribution/5.0-SNAPSHOT/hazelcast-distribution-5.0-20210217.140820-4-slim.tar.gz
tar zxvf hazelcast-distribution-5.0-20210217.140820-4-slim.tar.gz
rm hazelcast-distribution-5.0-20210217.140820-4-slim.tar.gz
cd hazelcast-5.0-SNAPSHOT-slim/bin
chmod +x hazelcast-start
chmod +x hazelcast
chmod +x hazelcast-stop
chmod +x common.sh
cd
cp -i hazelcast-5.0-SNAPSHOT-slim/bin /usr/local/bin/
./hazelcast-start