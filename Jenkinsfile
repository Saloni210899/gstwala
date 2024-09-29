pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        // KUBECONFIG = credentials('kubeconfig')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Cleanup and clone the repository
                    sh 'rm -rf gstwala'
                    git url: 'https://github.com/Saloni210899/gstwala.git', branch: 'dev'
                    sh 'ls -ltr'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    dir ('gstwala') {
                        sh 'ls -ltr'
                        // Build Docker image with the correct tag
                        sh 'docker build -t saloni098/gstwala-app:1.0 .'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    dir ('gstwala') {
                        // Set up virtual environment, install dependencies, and run Django tests
                        sh '''
                        python3 -m venv myenv
                        . myenv/bin/activate
                        pip install Django
                        python3 manage.py test
                        '''
                    }
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    dir ('gstwala') {
                        // Login to DockerHub using credentials
                        sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                        // Tag and push the Docker image
                        sh 'docker tag saloni098/gstwala-app:1.0 $DOCKERHUB_CREDENTIALS_USR/gstwala-app:1.0'
                        sh 'docker push $DOCKERHUB_CREDENTIALS_USR/gstwala-app:1.0'
                    }
                }
            }
        }
    }
}
