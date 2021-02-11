#!/bin/bash
clear
while [ ! -f /usr/local/bin/HelloWorld.java ]
do
  clear
  sleep .2
done

mkdir -p /usr/local/bin/src/main/java/com/hazelcast/jet/examples/helloworld

cp /usr/local/bin/HelloWorld.class /usr/local/bin/src/main/java/com/hazelcast/jet/examples/helloworld

cd /usr/local/bin

mvn exec:java -Dexec.mainClass=com.hazelcast.jet.examples.helloworld.HelloWorld
 