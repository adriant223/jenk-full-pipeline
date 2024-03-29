pipeline {
  agent {
    label "working-bee"
  }
//   tools {
//     jdk 'Java17'
//     maven 'Maven3'
// }
  environment{
    APP_NAME = "my-demo-app"
    RELEASE = "v1.0"
    DOCKER_USER = "yourDockerID"
    DOCKER_PASS = "docker-creds"
    IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
    IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    JENKINS_TOKEN = credentials("JENK_TOK")
    
    }
  stages {
       stage("del WS") {
      steps {
        cleanWs()  // Clean workspace before checkout
      }
    }

       stage("Git checkout") {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/your repo/your folder'
      }
    }
        stage("Test App") {
            steps {
                script {
          sh 'python3 src/app/tests/test_api.py'
          sh 'python3 src/app/tests/test_views.py'
                }
            }
        }    
        stage('Sonar Analyzing code') {
            environment {
        scannerHome = tool 'sonar-qube-scanner' // Must match SonarQube Scanner installations name in Jenkins
    }
            steps {
        withSonarQubeEnv('SonarQube') {     // Must match SonarQube servers name in Jenkins + Env variables should be enabled
            sh "${scannerHome}/bin/sonar-scanner"
                }
            }
         }
            stage('Sonar Quality Gate') {         
                steps{
                    script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube'  // Must match name of jenkins credential of type Secret Text 
                    }
                }
            }
        stage('Remove old Docker images') {
            steps{
                script{
                        sh """
                            sh rm-old-docker.sh  # Replace with the actual path to your script
                        """

                        }
                    }
                }
        stage('Docker IMG BUILD') {
            steps{
                script{
                docker.withRegistry('',DOCKER_PASS){
                    docker_image = docker.build "${IMAGE_NAME}"
                        }
                    }
                }
            }

        stage('Trivy Image Scanner') {
            steps{
                script{ docker.withRegistry('',DOCKER_PASS){
                        sh "trivy image --no-progress --severity HIGH,CRITICAL '${IMAGE_NAME}'" // example to stop pipeline --exit-code 5 =logic finds 5 HIGH/CRIT VULNs
                            }
                        }
                    }
                }

         stage('Docker Image PUSH') {
            steps{
                script{
                 docker.withRegistry('',DOCKER_PASS){
                    docker_image.push("${IMAGE_TAG}")

                        }
                    }
                }
            }
        stage("Trigger for ArgoCD IMAGE SYNC") {
            steps {
                script {
            
            sh "curl -v -k --user admin:${JENKINS_TOKEN} -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}'  'http://at-jenk.com/job/application-release-prod/buildWithParameters?token=YourTokenToTriggerPipelineBasedOn'"
                    }
                }
             }      
         
         } // stages ending
} // pipe line ending

