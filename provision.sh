#!/usr/bin/env bash

apt-get update
apt-get install -y default-jre unzip
wget -q https://github.com/archivesspace/archivesspace/releases/download/v2.1.2/archivesspace-v2.1.2.zip
unzip -q archivesspace-v2.1.2.zip
sudo chmod o+w /etc/rc.local 
echo "#!/bin/bash" > /etc/rc.local
echo "cd /home/ubuntu/archivesspace/ && ./archivesspace.sh start" >> /etc/rc.local
sudo /etc/init.d/rc.local restart
