#!/bin/bash
clear
while [ ! -f /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar ]
do
  clear
  sleep .2
done

chmod 755 /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar; java -jar /usr/local/bin/hazelcast-jet-examples-hello-world-4.5-SNAPSHOT.jar