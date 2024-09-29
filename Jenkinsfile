// pipeline {
//     agent any

//     environment {
//         DOCKERHUB_CREDENTIALS = credentials('dockerhub')
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 script {
//                     bat 'rd /s /q gstwala' // Equivalent to rm -rf on Windows
//                     bat 'git clone -b dev https://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@github.com/Saloni210899/gstwala.git'
//                     bat 'dir' // Equivalent to ls -ltr on Windows
//                 }
//             }
//         }

//         stage('Build') {
//             steps {
//                 script {
//                     dir('gstwala') {
//                         bat 'dir'
//                         bat 'docker build -t saloni098/gstwala-app:1.0 .' // Build Docker image
//                     }
//                 }
//             }
//         }

//         stage('Test') {
//             steps {
//                 script {
//                     dir('gstwala') {
//                         powershell '''
//                         python3 -m venv myenv
//                        .\\myenv\\Scripts\\Activate.bat
//                         pip install Django
//                         python manage.py test
//                         '''
//                     }
//                 }
//             }
//         }

//         stage('Push') {
//             steps {
//                 script {
//                     dir('gstwala') {
//                         bat 'docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%'
//                         bat 'docker tag saloni098/gstwala-app:1.0 %DOCKERHUB_CREDENTIALS_USR%/gstwala-app:1.0'
//                         bat 'docker push saloni098/gstwala-app:1.0'
//                     }
//                 }
//             }
//         }
//     }
// }

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
                    bat 'dir' // List directory contents
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
                        # Set the Python executable path explicitly
                        $pythonPath = "C:\\Users\\ronit\\AppData\\Local\\Programs\\Python\\Python312\\python.exe"
                        $pipPath = "C:\\Users\\ronit\\AppData\\Local\\Programs\\Python\\Python312\\Scripts\\pip.exe"

                        # Create virtual environment
                        Write-Host "Creating virtual environment..."
                        & $pythonPath -m venv myenv  
                        if ($LASTEXITCODE -ne 0) { 
                            Write-Host "Failed to create virtual environment." 
                            exit 1 
                        }

                        # Activate virtual environment
                        Write-Host "Activating virtual environment..."
                        .\\myenv\\Scripts\\Activate.bat  
                        if ($LASTEXITCODE -ne 0) { 
                            Write-Host "Failed to activate virtual environment." 
                            exit 1 
                        }

                        # Install Django
                        Write-Host "Installing Django..."
                        & $pipPath install Django  
                        if ($LASTEXITCODE -ne 0) { 
                            Write-Host "Failed to install Django." 
                            exit 1 
                        }

                        # Run tests
                        Write-Host "Running tests..."
                        & $pythonPath manage.py test  
                        if ($LASTEXITCODE -ne 0) { 
                            Write-Host "Tests failed." 
                            exit 1 
                        }
                        '''
                    }
                }
            }
        }

        stage('Push') {
    steps {
        script {
            dir('gstwala') {
                // Login to Docker Hub using --password-stdin
                bat '''
                echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin
                '''
                bat 'docker tag saloni098/gstwala-app:1.0 %DOCKERHUB_CREDENTIALS_USR%/gstwala-app:1.0'
                bat 'docker push saloni098/gstwala-app:1.0'
            }
        }
    }
}

    }
}
