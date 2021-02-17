#!/bin/bash
echo "Starting Jet"
clear
cd /usr/local/bin
wget -4 https://github.com/hazelcast/hazelcast-jet/releases/download/v4.4/hazelcast-jet-4.4.tar.gz
tar zxvf hazelcast-jet-4.4.tar.gz
rm hazelcast-jet-4.4.tar.gz
cd hazelcast-jet-4.4/bin
chmod +x jet-start
chmod +x jet
chmod +x jet-stop
chmod +x common.sh
./jet-start