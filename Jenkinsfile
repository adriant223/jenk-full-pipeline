pipeline {
    agent{
        label "my-working-bee"
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }

    stages {
        stage('Workspace cleaning') {
            steps {
                cleanWs()
            }
        }

        stage('checkout  [S][C][M]')
           steps{
            git branch: 'main', credentialsId: 'github', url: 'https://github.com/adriant223/jenk-full-pipeline'
           }
        }
}

