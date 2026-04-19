pipeline {
    agent any
    environment {
        DOCKERHUB_USERNAME = "magsnan"
        IMAGE_NAME = "sample-web-app"
        CONTAINER_NAME = "nginx-server-19th-april"
        FULL_IMAGE = "${DOCKERHUB_USERNAME}/${IMAGE_NAME}"
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

        stage('Push to Docker Hub') {
            steps {
                echo "Pushing image to Docker Hub..."
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DH_USER',
                    passwordVariable: 'DH_PASS'
                )]) {
                    sh "echo $DH_PASS | docker login -u $DH_USER --password-stdin"
                    sh "docker push ${FULL_IMAGE}:${env.BUILD_ID}"
                    sh "docker push ${FULL_IMAGE}:latest"
                }
            }
        }

        
        stage('Deploy') {
            steps {
                echo "Deploying to Host..."
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker run -d --name ${CONTAINER_NAME} -p 8090:80 ${FULL_IMAGE}:latest"
            }
        }

    }
    post {
        always {
            echo "Housekeeping: Cleaning up unused Docker images..."
            // This prevents your Lenovo laptop disk from filling up
            sh "docker image prune -f"
        }
        success {
            echo '✅ Pipeline succeeded! Website is live at http://localhost:8090'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs above.'
        }
    }
}

