#!/bin/bash
clear
while [ ! -f /usr/local/bin/HelloWorld.java ]
do
  clear
  sleep .2
done

cd /usr/local/bin

mvn exec:java -Dexec.mainClass=com.hazelcast.jet.examples.helloworld.HelloWorld
 