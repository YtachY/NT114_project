pipeline {
    agent any
    parameters {
        string defaultValue: '/home/kagi/target', description: '', name: 'INPUT_LOCATION', trim: true
    }
    stages {
        stage('Start pentest') {
            steps {
                script {
                    dir(INPUT_LOCATION) {
                        files = findFiles(glob: '*.apk')
                    }
                    files.each { f ->
                        def TASK_COLLECTION = [:]
                        TASK_COLLECTION["Check debuggable file ${f}"] =  {
                            sh "echo '[+] Checking ${env.INPUT_LOCATION}/${f} if it could be debuggable...'"
                            def result = sh(script: "${env.INPUT_LOCATION}/check-debug.sh ${env.INPUT_LOCATION}/${f}", returnStdout:true).trim()
                            if (result.isEmpty()) {
                                sh "echo safe"
                            }
                            else {
                                sh "echo '${env.INPUT_LOCATION}/${f}' is DEBUGGABLE"
                            }
                        }
                        TASK_COLLECTION["get permissions file ${f}"] = {
                            list_all_permission_cmd = "aapt d permissions ${env.INPUT_LOCATION}/${f}"
                            echo sh(label: 'list all permissions', returnStdout: true, script: list_all_permission_cmd).trim()
                        }
                        parallel(TASK_COLLECTION)
                    }
                }
            }
        }
    }
}