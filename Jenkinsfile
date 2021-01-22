def repoName = "tfe201_examples"                         //Repo to store TF code for the TFE Workspace
def branchName = "lab10"
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
        withCredentials([string(credentialsId: 'TFE-Team-API-Token', variable: 'token')]) {
          sh '''
            set +x
            wget https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip
            unzip -o terraform_0.14.5_linux_amd64.zip
            rm -rf *.zip*
            sed -i 's/TOKEN/'"$token"'/g' terraformrc
            export TF_CLI_CONFIG_FILE=./terraformrc
            ./terraform init -no-color -backend-config="token=$token" 
            ./terraform validate -no-color
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
            ./terraform apply -no-color
          '''
          sleep 60
        }
       }
      

     stage('3. Delete Infrastructure'){
       steps{
         input("Delete Infrastructure?")
      }
    }


     stage('4. Cleanup Dev Infrastructure'){
       steps {
          sh '''
             set +x
             ./terraform destroy -no-color
          '''
        }
    }

  } //stages
}
