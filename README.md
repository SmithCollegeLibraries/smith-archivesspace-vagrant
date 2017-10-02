# ArchivesSpace local development environment
Requires Vagrant https://www.vagrantup.com/

Sets up the following software:
- ArchivesSpace v2.1.2
- MySQL and the Java-MySQL connector
- Latest version of Java at time of provisioning

# Setup
Vagrant creates a virtual machine on demand and set's things up on the VM for you. Follow the simple instructions below to set it up and use it.

## Databse contents
Before you run the Vagrant installer you may want the SQL dump from the instance you are cloning. If you don't supply an SQL dump, the vagrant will use the demo setup instead. Either way it will use a full fledged MySQL database. Place the SQL dump file in this folder and call it ```dump.sql```. The name must match exactly! Make sure that it is unzipped first if it is gzipped. 

## Run the setup
To create the virtual machine and set up archivespsace on it, simply use the following command:
```
cd smith-archivesspace-vagrant/
vagrant up
```
This may take a couple minutes to do everything. Enough time to go make a fresh pot of tea...

# Accessing ArchivesSpace
Once online, ArchivesSpace is accessible at these locations:
- http://localhost:8089/ -- the backend
- http://localhost:8080/ -- the staff interface
- http://localhost:8081/ -- the public interface
- http://localhost:8082/ -- the OAI-PMH server
- http://localhost:8090/ -- the Solr admin console

# Accessing the environment
## SSH into the virtual machine:
```
vagrant ssh
```

## Sharing files
This folder is accessible on the virtual machine at the location ```/vagrant```.
```
cd /vagrant
```

# Teardown
Stop the virtual machine until next time
```
vagrant suspend
```

OR completely delete the virtual machine to save space. Next time you run ```vagrant up```, Vagrant will recreate the virtual machine from scratch like the first time.
```
vagrant destroy
```

# Logs
ArchivesSpace logs are available at ```/home/ubuntu/archivesspace/logs```

# TODO
- Create method to import production SQL dump
