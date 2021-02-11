#!/bin/bash
clear
while [ ! -f /usr/local/tmp/hazelcast-jet-4.4/LICENSE ]
do
  clear
  echo "Downloading Jet source..."
  sleep .2
done

cd /usr/local/tmp/hazelcast-jet-4.4
bin/jet-start