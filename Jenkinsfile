pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials ('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials ('AWS_SECRET_ACCESS_KEY')
    }
    stages {
        stage('Download config from github') {
            steps {
                sh 'git clone https://github.com/cobidennis/hrapp-nodes-config.git'
            }
        }
        stage('Download Terraform Var Files from S3') {
            steps {
                script {
                    def s3Bucket = 'dobee-buckets'
                    def terraformBackend = 'devops-training/terraform/hr-app/backend.tfvars'
                    def terraformVars = 'devops-training/terraform/hr-app/terraform.tfvars'
                    def localFilePath = 'hrapp-nodes-config'

                    sh "aws s3 cp s3://${s3Bucket}/${terraformBackend} ${localFilePath}"
                    sh "aws s3 cp s3://${s3Bucket}/${terraformVars} ${localFilePath}"

                    def backendVarsExists = fileExists("${localFilePath}/backend.tfvars")
                    def terraformVarsExists = fileExists("${localFilePath}/terraform.tfvars")

                    if (backendVarsExists && terraformVarsExists) {
                        echo "All tvars are available. Proceeding to the next stage."
                    } else {
                        error "Not all tvars files exist. Aborting the pipeline."
                    }
                }
            }
        }
        stage ('Terraform: Build and manage Infrastructure') {
            when {
                expression {
                    // This stage will execute only if all tvars file are availabe
                    return backendVarsExists && terraformVarsExists
                }
            }
            steps {
                sh '''
                    cd hrapp-nodes-config
                    terraform init -backend-config=backend.tfvars
                    terraform apply -auto-approve
                    
                '''
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}
