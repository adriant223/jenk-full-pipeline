pipeline {
  agent {
    label "my-working-bee"
  }
//   tools {
//     // Add any necessary tools here (e.g., Python)
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

    stage("Run Python Script") {  // Added stage for running the script
      steps {
        script {  // Use the 'script' block for shell commands
          sh 'python3 src/run.py'  // Execute the Python script
        }
      }
    }
  }
}
