pipeline {
  agent {
    label "working-bee"
  }
//   tools {
//     sonarQube 'sonar'
//   }
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

    // stage("Create Virtual Environment") {
    //   steps {
    //     script {
    //       sh 'python3 -m venv venv'  // Create virtual environment named 'venv'
    //     }
    //   }
    // }

    // // Stage 2: Install Dependencies and Run Script
    // stage("Install Dependencies and Run Script") {
    //   steps {
    //     script {
    //       sh 'source venv/bin/activate'  // Activate the virtual environment
    //       sh 'venv/bin/pip install flask py-cpuinfo psutil'  // Install dependencies within venv
    //       sh 'venv/bin/python src/run.py'  // Execute the Python script
    //     }
    //   }
    // }
    //   stage("Install Dependencies and Run Script") {
    //   steps {
    //     script {
    //       sh 'source venv/bin/activate'  // Activate the virtual environment
    //       sh 'venv/bin/pip install flask py-cpuinfo psutil'  // Install dependencies within venv
    //       sh 'venv/bin/python src/run.py'  // Execute the Python script
    //     }
    //   }
    // }
        stage("Test App") {
      steps {
        script {
          sh 'python3 src/app/tests/test_api.py'
          sh 'python3 src/app/tests/test_views.py'
        }
      }
        }    
  stage('SonarQube Analysis') {
    steps{
        script{
            withSonarQubeEnv(credentialsId: 'jenkins-sonarqube')
            sh 'mvn sonar:sonar'
      }
        }
      }
    }
}


