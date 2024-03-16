pipeline {
  agent {
    label "working-bee"
  }
  tools {
    jdk 'Java17'
    maven 'Maven3'
  }
  environment{
    APP_NAME = "my-demo-app"
    RELEASE = "v1.0"
    DOCKER_USER = "atimis224"
    DOCKER_PASS = "docker-creds"
    IMAGINE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
    IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
  }
  stages {
    stage("del WS") {
      steps {
        cleanWs()  // Clean workspace before checkout
      }
    }

    stage("Git checkout") {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/adriant223/jenk-full-pipeline'
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
        scannerHome = tool 'sonar-qube-scanner'
    }
    steps {
        withSonarQubeEnv('SonarQube') {
            sh "${scannerHome}/bin/sonar-scanner"
            
        // timeout(time: 1, unit: 'MINUTES') {
        //     waitForQualityGate abortPipeline: true
        // }
                }
            }
         }
    stage('Sonar Quality Gate') {
        steps{
            script{
                waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube'
                }
            }
        }
        stage('Docker IMG BD&PUSH') {
        steps{
            script{
                docker.withRegistry('',DOCKER_PASS){
                    docker_image = docker.build "${IMAGE_NAME}"
                }
                 docker.withRegistry('',DOCKER_PASS){
                    docker_image.push("${IMAGE_TAG}")
                }
                }
            }
        }     
         
         } // stages ending
} // pipe line ending

