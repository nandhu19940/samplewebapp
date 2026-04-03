pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo "Pulling latest code from GitHub..."
            }
        }
        stage('validate') {
            steps {
                echo "Validating required file for build exist....."
                sh ' test -f index.html && echo "index.html file is present" || exit 1'
            }
        }
        stage('Build') {
            steps {
                echo "Build Started..."
                sh 'cat index.html'
                echo "Build Successful!"
            }
        }
    }
}
