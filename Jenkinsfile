pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo "Pulling latest code from GitHub..."
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
