pipeline {
    agent any
    parameters {
        string defaultValue: '/home/kagi/target', description: '', name: 'INPUT_LOCATION', trim: true
    }
    stages {
        stage('Check debuggble') {
            steps {
                script {
                    dir(INPUT_LOCATION) {
                        files = findFiles(glob: '*.apk')
                    }
                    files.each { f ->
                        def TASK_COLLECTION = [:]
                        TASK_COLLECTION["Use aapt"] =  {
                            sh "ls ${env.INPUT_LOCATION}/${f}"
                            check_debug_cmd = "aapt list -v -a ${f} \| grep debuggable"
                            upload_result = sh label: 'Check debuggable', returnStdout: true, script: check_debug_cmd
                        }
                        TASK_COLLECTION["Use aapt version 2"] = {
                            check_debug_cmd = "aapt dump xmltree ${f} AndroidManifest.xml | grep debuggable"
                            upload_result = sh label: 'Check debuggable', returnStdout: true, script: check_debug_cmd
                        }
                        parallel(TASK_COLLECTION)
                    }
                }
            }
        }
    }
}