def repoName = "tfe201_examples"                         //Repo to store TF code for the TFE Workspace
def branchName = "lab10"
def repoSshUrl = "git@github.com:wasanthag/tfe201_examples.git"   //Must be ssh since we're using sshagent()
//Credentials
def gitCredentials = 'github-wasanthag'                   //Credential ID in Jenkins of your GitHub SSH Credentials
def tfeCredentials = 'TFE-Team-API-Token'                         //Credential ID in Jenkins secret text of TFE Team API Token


 pipeline {
   agent any
   
   triggers {
    githubPush()
  }
      
  stages {
    stage('1. Validate TF code'){
      environment {
          REPO_NAME = "${repoName}"
          BRANCH_NAME = "${branchName}"

      }
      steps {
        withCredentials([string(credentialsId: 'github-wasanthag', variable: 'TOKEN')])) {
          sh '''
            set +x
            sed -i 's/TOKEN/'"$token"'/g' terraformrc
            export TF_CLI_CONFIG_FILE=./terraformrc
            terraform init -no-color -backend-config="token=$token" 
            terraform validate -no-color
          '''
        }
       }
    } 
    
    stage('2. Create Dev Infrastructure'){
      environment {
          REPO_NAME = "${repoName}"
          BRANCH_NAME = "${branchName}"
      }
      steps {
          sh '''
            set +x
            terraform apply -no-color
          '''
          sleep 60
        }
       }
      }

     stage('6. Delete Infrastructure'){
      steps{
        input("Delete Infrastructure?")
      }
    }


    stage('5. Cleanup Dev Infrastructure'){
      steps {
          sh '''
             set +x
             terraform destroy -no-color
          '''
        }
    }


  } //stages
}
