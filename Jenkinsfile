pipeline {
    agent any 
    stages {
        stage('Dev') {
            steps {
                echo 'Hello dev first!' 
            }
            steps {
                echo 'Hello dev second!' 
            }
        }
        stage('Test') {
            steps {
                echo 'Hello test!' 
            }
            steps {
                echo 'Hello double!' 
            }
        }
        stage('Build') {
            steps {
                echo 'Hello build!' 
            }
        }
    }
}