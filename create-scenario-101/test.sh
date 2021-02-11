#!/bin/bash
clear
while [ ! -f /usr/local/bin/hazelcast/jet/examples/helloworld/src/main/java/com/hazelcast/jet/examples/helloworld/HelloWorld.java ]
do
  clear
  sleep .2
done

cd /usr/local/bin/hazelcast/jet/examples/helloworld

mvn exec:java -Dexec.mainClass=com.hazelcast.jet.examples.helloworld.HelloWorld
 