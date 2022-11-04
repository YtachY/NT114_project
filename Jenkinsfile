pipeline {
    agent any
    parameters {
        string defaultValue: '/home/kagi/target', description: '', name: 'INPUT_LOCATION', trim: true
    }
    stages {
        stage('Check debuggable') {
            steps {
                script {
                    dir(INPUT_LOCATION) {
                        files = findFiles(glob: '*.apk')
                    }
                    files.each { f ->
                        def TASK_COLLECTION = [:]
                        TASK_COLLECTION["Check {f}"] =  {
                            sh "echo '[+] Checking ${env.INPUT_LOCATION}/${f} if it could be debuggable...'"
                            def result = sh(script: "${env.INPUT_LOCATION}/check-debug.sh ${env.INPUT_LOCATION}/${f}", returnStdout:true).trim()
                            sh "echo ${result}"
                            // if (result == 1) {
                            //     sh "echo '${env.INPUT_LOCATION}/${f}' is debuggable"
                            // }
                            // else {
                            //     sh "echo safe"
                            // }
                        }
                        parallel(TASK_COLLECTION)
                    }
                }
            }
        }
    }
}