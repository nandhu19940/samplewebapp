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
                cat index.html
                echo "Build Successful!"
            }
        }
    }
}
