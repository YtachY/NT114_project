pipeline {
    agent {
        any
    }
    parameters {
        string defaultValue: '/home/kagi/target/', description: '', name: 'INPUT_LOCATION', trim: true
    }
    stage('Analysis') {
        steps {
            script {
                dir(INPUT_LOCATION) {
                    files = findFiles(glob: '*.*')
                }
                files.each { f ->
                    def TASK_COLLECTION = [:]
                    TASK_COLLECTION["MOBSF"] =  {
                    def AUTH_KEY = 'e3f181a14905748e06d820c9082fc37ec0211e1b024c13e3c24ef28b6ad92d4f'
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