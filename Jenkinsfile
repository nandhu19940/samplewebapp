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
    }
    post {
        success {
            echo "PIPELINE SUCCEEDED — index.html built and archived successfully!"
            echo "Build Number: ${env.BUILD_NUMBER}"
            echo "Job Name: ${env.JOB_NAME}"
        }
        failure {
            echo "PIPELINE FAILED — something went wrong. Check the logs above!"
            echo "Build Number: ${env.BUILD_NUMBER}"
            echo "Job Name: ${env.JOB_NAME}"
        }
    }
}
