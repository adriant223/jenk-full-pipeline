pipeline {
  agent {
    label "working-bee"
  }
  tools {
    jdk 'Java17'
    maven 'Maven3'
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
stage('Sonarqube') {
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
    }


}

