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
                        TASK_COLLECTION["Use script"] =  {
                            check_debug_cmd = "${env.INPUT_LOCATION}/check-debug.sh ${env.INPUT_LOCATION}/${f}"
                            def result = sh label: 'Check debuggable', returnStdout: true, script: check_debug_cmd
                            sh "echo ${result}"
                        }
                        parallel(TASK_COLLECTION)
                    }
                }
            }
        }
    }
}