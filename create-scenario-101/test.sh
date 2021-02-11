#!/bin/bash
clear
while [ ! -f /usr/local/tmp/hazelcast-jet-4.4/LICENSE ]
do
  clear
  sleep .2
done

cd hazelcast-jet-4.4
bin/jet-start