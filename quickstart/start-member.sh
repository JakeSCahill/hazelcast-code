#!/bin/bash
echo "Installing Hazelcast"
wget -qO - https://repository.hazelcast.com/api/gpg/key/public | sudo apt-key add -
echo "deb https://repository.hazelcast.com/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt update && sudo apt install hazelcast