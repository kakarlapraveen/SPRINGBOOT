pipeline {
    agent any

    tools {
        maven 'maven' // Ensure Maven is configured in Jenkins with this label
    }

    environment {
        DOCKER_IMAGE = 'kakarlapraveena/spring'
        DOCKER_TAG = 'latest'
        CREDENTIAL = 'docker-hub-credentials'
    }

        stage('Build jar') {
            steps {
                echo 'Building the JAR file...'
                sh 'mvn clean package'
            }
        }

        stage('CleanUp Docker Images and Containers') {
            steps {
                echo 'Cleaning up Docker images and containers...'
                script {
                    sh '''
                        docker rm -f my-container || echo "No containers to remove."
                        docker rmi -f $(docker images -q -f dangling=true) || echo "No dangling images to remove."
                    '''
                }
            }
        }

        stage('Docker Login') {
           steps {
               echo 'Logging in to DockerHub...'
               script {
                  withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
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
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
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

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
