pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    bat 'rd /s /q gstwala' // Equivalent to rm -rf on Windows
                    bat 'git clone -b dev https://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@github.com/Saloni210899/gstwala.git'
                    bat 'dir' // Equivalent to ls -ltr on Windows
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    dir('gstwala') {
                        bat 'dir'
                        bat 'docker build -t saloni098/gstwala-app:1.0 .' // Build Docker image
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    dir('gstwala') {
                        powershell '''
                        python3 -m venv myenv
                        .\\myenv\\Scripts\\Activate.ps1
                        pip install Django
                        python manage.py test
                        '''
                    }
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    dir('gstwala') {
                        bat 'docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%'
                        bat 'docker tag saloni098/gstwala-app:1.0 %DOCKERHUB_CREDENTIALS_USR%/gstwala-app:1.0'
                        bat 'docker push saloni098/gstwala-app:1.0'
                    }
                }
            }
        }
    }
}
