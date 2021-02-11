#!/bin/bash
clear
while [ ! -f /usr/local/bin/HelloWorld.java ]
do
  clear
  sleep .2
done

mkdir -p /usr/local/bin/src/main/java/com/hazelcast/jet/examples/helloworld

mkdir -p /usr/local/bin/src/main/resources

cp /usr/local/bin/HelloWorld.class /usr/local/bin/src/main/java/com/hazelcast/jet/examples/helloworld

cp /usr/local/bin/hazelcast.yaml /usr/local/bin/src/main/resources

cd /usr/local/bin

mvn exec:java -Dexec.mainClass=com.hazelcast.jet.examples.helloworld.HelloWorld
 