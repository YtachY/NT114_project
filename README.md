# capstone
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
- [x] Github Interactive
- [x] Blue Ocean

- [ ] Jenkins file run framework
```Groovy
pipeline {
agent any

parameters {

string defaultValue: '/home/kagi/target', description: '', name: 'INPUT_LOCATION', trim: true

}

stages {

stage('Analysis') {

steps {

script {

dir(INPUT_LOCATION) {

files = findFiles(glob: '*.*')

}

files.each { f ->

def TASK_COLLECTION = [:]

TASK_COLLECTION["MOBSF"] = {

def AUTH_KEY = 'd7e6d5516468f345117e2555d05ff589e5bead89b636883f76b66bc23af8d4eb'

upload_cmd = "curl -s -S -F 'file=@${env.INPUT_LOCATION}/${f}' http://localhost:8000/api/v1/upload -H 'Authorization:${AUTH_KEY}'"

upload_result = sh label: 'Upload Binary', returnStdout: true, script: upload_cmd

def response_map = readJSON text: upload_result

def app_type = response_map["scan_type"]

def app_hash = response_map["hash"]

def app_name = response_map["file_name"]

scan_start_cmd = "curl -s -S -X POST --url http://localhost:8000/api/v1/scan --data 'scan_type=${app_type}&file_name=${app_name}&hash=${app_hash}' -H 'Authorization:${AUTH_KEY}'"

sh label: 'Start Scan of Binary', returnStdout: true, script: scan_start_cmd

}

TASK_COLLECTION["Qark"] = {

sh "qark --apk ${env.INPUT_LOCATION}/${f}"

}

parallel(TASK_COLLECTION)

}

}

}

}

}

}
```
```groovy
pipeline { agent any parameters { string defaultValue: '/home/kagi/target', description: '', name: 'INPUT_LOCATION', trim: true } stages { stage('Check debuggble') { steps { script { dir(INPUT_LOCATION) { files = findFiles(glob: '*.apk') } files.each { f -> def TASK_COLLECTION = [:] TASK_COLLECTION["Use aapt"] = { check_debug_cmd = "aapt list -v -a ${f} | grep debuggable" upload_result = sh label: 'Check debuggable', returnStdout: true, script: check_debug_cmd } TASK_COLLECTION["Use aapt version 2"] = { check_debug_cmd = "aapt dump xmltree ${f} AndroidManifest.xml | grep debuggable" upload_result = sh label: 'Check debuggable', returnStdout: true, script: check_debug_cmd } parallel(TASK_COLLECTION) } } } } } }

```

# References 
| num |                         name                         |   tag   |
| --- |:----------------------------------------------------:|:-------:|
| 1   | [Repo link](https://github.com/YtachY/NT114_project) | #github |
|     |                                                      |         |
