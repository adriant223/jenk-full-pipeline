pipeline{
    agent{
        label "my-working-bee"
    }
    tools{
       sh "python3"
    }
    stages{
        stage("del WS") {
            steps {
                cleanWs()
            }
        }

        stage("Git checkout"){
           steps{
            git branch: 'main', credentialsId: 'github', url: 'https://github.com/adriant223/jenk-full-pipeline'
           }
        }
      }
    }