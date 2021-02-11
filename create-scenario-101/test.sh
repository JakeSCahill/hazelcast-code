#!/bin/bash
clear
while [ ! -f /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar ]
do
  clear
  sleep .2
done

mkdir -p /usr/local/bin/com/hazelcast/jet/examples/helloworld

cp /usr/local/bin/HelloWorld.class /usr/local/bin/com/hazelcast/jet/examples/helloworld

cd /usr/local/bin

chmod 755 HelloWorld.class; java -cp . com.hazelcast.jet.examples.helloworld.HelloWorld