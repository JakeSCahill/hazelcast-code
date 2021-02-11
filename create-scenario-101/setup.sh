#!/bin/bash
clear
mkdir -p /usr/local/tmp
cd /usr/local/tmp
echo "Downloading the Jet source..."
wget https://github.com/hazelcast/hazelcast-jet/releases/download/v4.4/hazelcast-jet-4.4.tar.gz
tar zxvf hazelcast-jet-4.4.tar.gz
rm hazelcast-jet-4.4.tar.gz