#!/usr/bin/env bash

# Path (on the vagrant box) of the sql dump file to load
sqlDumpFile="/vagrant/dump.sql"

# Install needed Ubuntu software packages
export DEBIAN_FRONTEND=noninteractive # don't prompt me for stuff REALLY
apt-get update
apt-get -q -y install default-jre unzip mysql-server

# Download AS
wget -q https://github.com/archivesspace/archivesspace/releases/download/v2.5.0/archivesspace-v2.5.1.zip
unzip -q archivesspace-v2.5.1.zip

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

# Initialize the database either with the provided SQL dump or stock config
if [ -f "$sqlDumpFile" ]
then
  echo "$sqlDumpFile found. Importing SQL dump."
  # Import database dump
  mysql -u as --password=as123 archivesspace < /vagrant/dump.sql
else
 echo "$sqlDumpFile not found. Using demo database instead"
fi

# Add AS to system startup scripts
sudo chmod o+w /etc/rc.local 
echo "#!/bin/bash" > /etc/rc.local
echo "cd /home/ubuntu/archivesspace/ && ./archivesspace.sh start" >> /etc/rc.local

# Reload system startup scripts to run AS for the first time
sudo /etc/init.d/rc.local restart

echo "ArchivesSpace launching in the background. In a minute or two it will be available at http://localhost:8080."
echo "To watch logs run: vagrant ssh, then run: tail -f archivesspace/logs/archivesspace.out"
