# NT114_project
# Install Jenkins
- [ ] Java
```shell
sudo apt update
sudo apt install openjdk-11-jre
java -version
```
- [ ] Install file .war
```shell
wget https://get.jenkins.io/war-stable/2.375.1/jenkins.war
```
- [ ] Script run jenkins
```shell
#!/bin/bash

docker start mobisf-server
nohup java -jar /home/kagi/my-jenkins/jenkins.war --httpPort=9999 --logfile=app.log  >> server-jenkins.log 2>&1 &

tail -f /home/kagi/my-jenkins/server-jenkins.log
```
- [x] Pipeline Utility Steps
- [ ] Github Interactive
- [x] Blue Ocean


# References 
| num |                         name                         |   tag   |
| --- |:----------------------------------------------------:|:-------:|
| 1   | [Repo link](https://github.com/YtachY/NT114_project) | #github |
|     |                                                      |         |
