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
        stage ('archive') {
            steps {
                echo "Archiving build artifacts..."
                archiveArtifacts artifacts: 'index.html', fingerprint: true
                echo "Artifact archived successfully!"
            }
        }
        stage('Deploy') {
    steps {
        echo "Deploying artifact to Nginx container"
        sh "docker cp index.html nginx-server:/usr/share/nginx/html/index.html"
    }
}
    }
    post {
        success {
            echo '✅ Pipeline succeeded! Website is live at http://localhost:8090'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs above.'
        }
    }
}
