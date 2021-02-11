#!/bin/bash
clear
while [ ! -f /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar ]
do
  clear
  sleep .2
done

mkdir -p /usr/local/bin/com/hazelcast/jet/examples/helloworld

cp /usr/local/bin/HelloWorld.class /usr/local/bin/com/hazelcast/jet/examples/helloworld

chmod 755 /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar; java -cp /usr/local/bin -jar /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar