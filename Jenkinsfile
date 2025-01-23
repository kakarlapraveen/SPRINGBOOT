pipeline {
    agent any

    tools {
        maven 'maven'  // Ensure Maven is configured in Jenkins with this label
    }

    environment {
        DOCKER_IMAGE = 'punit1/project'       // Docker image name
        DOCKER_TAG = 'latest'                // Docker tag
        CREDENTIAL = 'docker-hub-credentials' // Jenkins credentials ID for DockerHub
    }

    stages {
        stage('Clone Repo') {
            steps {
                echo 'Cloning the Git repository...'
                git branch: 'main', url: 'https://github.com/punit-appi/SPRINGBOOT.git'
            }
        }

        stage('Build jar') {
            steps {
                echo 'Building the JAR file using Maven...'
                sh 'mvn clean package'
            }
        }

        stage('CleanUp Docker Images and Containers') {
            steps {
                echo 'Cleaning up Docker images and containers...'
                script {
                    sh '''
                        # Remove the running container (if it exists)
                        docker rm -f my-container || echo "No containers to remove."
                        
                        # Remove dangling images
                        docker rmi -f $(docker images -q -f dangling=true) || echo "No dangling images to remove."
                    '''
                }
            }
        }

        stage('Docker Login to Server') {
            steps {
                echo 'Logging in to DockerHub...'
                script {
                    withCredentials([usernamePassword(credentialsId: CREDENTIAL, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                            docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        '''
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker image...'
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing the Docker image to DockerHub...'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', CREDENTIAL) {
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Run the Container') {
            steps {
                echo 'Running the Docker container...'
                sh "docker run -it -d --name my-container -p 8081:8081 ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }
}
