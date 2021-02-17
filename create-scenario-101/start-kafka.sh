#!/bin/bash
echo "Starting Kafka"
clear
cd /usr/local/bin
wget http://mirror.cc.columbia.edu/pub/software/apache/kafka/2.7.0/kafka_2.13-2.7.0.tgz
tar xvf kafka_2.13-2.7.0.tgz
rm kafka_2.13-2.7.0.tgz
cd kafka_2.13-2.7.0/bin
chmod +x zookeeper-server-start.sh
chmod +x kafka-server-start.sh
cd ..
bin/zookeeper-server-start.sh config/zookeeper.properties && bin/kafka-server-start.sh config/server.properties