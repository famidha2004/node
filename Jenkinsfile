pipeline {
    agent any

    tools {
        nodejs 'NodeJS-20'
    }

    environment {
        IMAGE_NAME = 'vite-app'
        PROJECT_DIR = 'node_project'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/famidha2004/node.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh "cd ${PROJECT_DIR} && npm install"
            }
        }

        stage('Build Vite') {
            steps {
                sh "cd ${PROJECT_DIR} && npm run build"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t vite-app:latest .'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker rm -f vite-app || true
                docker run -d --name vite-app -p 8080:80 vite-app:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful'
        }
        failure {
            echo 'Deployment Failed'
        }
    }
}
