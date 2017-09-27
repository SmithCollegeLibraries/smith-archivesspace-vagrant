#!/usr/bin/env bash

# Install needed Ubuntu software packages
export DEBIAN_FRONTEND=noninteractive # don't prompt me for stuff REALLY
apt-get update
apt-get -q -y install default-jre unzip mysql-server

# Download AS
wget -q https://github.com/archivesspace/archivesspace/releases/download/v2.1.2/archivesspace-v2.1.2.zip
unzip -q archivesspace-v2.1.2.zip

# Install java mysql connector
wget -q https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.44.tar.gz
tar xzf mysql-connector-java-5.1.44.tar.gz
cp mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar archivesspace/lib/

# Create database
mysql < /vagrant/setup-db.sql

# Add db configuration to AS config file
echo 'AppConfig[:db_url] = "jdbc:mysql://localhost:3306/archivesspace?user=as&password=as123&useUnicode=true&characterEncoding=UTF-8"' >> archivesspace/config/config.rb

# Run initial database tables setup
archivesspace/scripts/setup-database.sh

# Add AS to system startup scripts
sudo chmod o+w /etc/rc.local 
echo "#!/bin/bash" > /etc/rc.local
echo "cd /home/ubuntu/archivesspace/ && ./archivesspace.sh start" >> /etc/rc.local

# Reload system startup scripts to run AS for the first time
sudo /etc/init.d/rc.local restart
