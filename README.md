# NT114_project
# Install Jenkins
- Java
```shell
sudo apt update
sudo apt install openjdk-11-jre
java -version
```
- Install file .war
```shell
wget https://get.jenkins.io/war-stable/2.375.1/jenkins.war
```
- Script run jenkins
```shell
#!/bin/bash

nohup java -jar jenkins.war --httpPort=9999 --logfile=app.log 2>&1 >> jenkins.log &
```
