pipeline{
    agent any
    environment {
        GITHUB_ACCESS_TOKEN   = credentials('loyalcomps-github-token') // add jenkins credential and add the name here
        GIT_SSH_COMMAND = 'ssh -o StrictHostKeyChecking=no'
        CODECOMMIT_REPO_URL   = 'ssh://git-codecommit.ap-south-1.amazonaws.com/v1/repos/menachery'
        GITHUB_REPO_URL      = 'git@github.com:loyalcomps/testrepo.git'
    
    }
    stages{
    stage ("clone cc repo"){
        steps{
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: "vignesh_aws_credentials", // add jenkins credential and add the name here
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                
                //sh "rm -rf codecommit_repo"
                sh "rm -rf codecommit_repo"
                sh "git clone $CODECOMMIT_REPO_URL codecommit_repo"
            }
    }
}
    stage('Push to GitHub Repository') {
            steps {
                script {
                    // Configure Git with GitHub credentials
                    withCredentials([string(credentialsId: 'loyalcomps-github-token', variable: 'loyalcomps-github-token')]) {
                        sh "git config --global user.email 'vignesh@loyalitsolutions.com'"
                        sh "git config --global user.name 'vignesh'"
                        sh "git -C codecommit_repo remote add github $GITHUB_REPO_URL"

                        // Push the CodeCommit repository to GitHub
                   
                        sh "git -C codecommit_repo checkout -b production --track origin/production"
                        sh "git -C codecommit_repo fetch github"
                        sh "git -C codecommit_repo rebase github/production"
                      
                        sh "git -C codecommit_repo push github production"
                        
                        sh "git -C codecommit_repo checkout -b staging --track origin/staging"
                        sh "git -C codecommit_repo fetch github"
                        sh "git -C codecommit_repo rebase github/staging"
                      
                        sh "git -C codecommit_repo push github staging"
                        
                        
                    }
                }
            }
        }
    }
}
