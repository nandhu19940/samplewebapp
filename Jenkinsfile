pipeline {
    agent any
    environment {
        IMAGE_NAME = "sample-web-app"
        CONTAINER_NAME = "nginx-serve"
    }
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
                sh 'test -f Dockerfile && echo "Dockerfile is present" || exit 1'
            }
        }

        stage ('archive') {
            steps {
                echo "Archiving build artifacts..."
                archiveArtifacts artifacts: 'index.html', fingerprint: true
                echo "Artifact archived successfully!"
            }
        }
        
        stage('Build image') {
            steps {
                echo "Building Image inside Jenkins Container..."
                // This command goes through the socket to your Windows Docker Desktop
                sh "docker build -t ${IMAGE_NAME}:${env.BUILD_ID} ."
                sh "docker tag ${IMAGE_NAME}:${env.BUILD_ID} ${IMAGE_NAME}:latest"
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Deploying to Host..."
                // Stop and remove the old standalone Nginx container
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                // Start the new one
                sh "docker run -d --name ${CONTAINER_NAME} -p 8090:80 ${IMAGE_NAME}:latest"
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

