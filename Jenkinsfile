pipeline {
    agent any

    parameters {
        booleanParam(name: 'INIT_TERRAFORM', defaultValue: false, description: 'Check to init Terraform changes')
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to destroy Terraform resources')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/jbsbuilder/cloud-resume-challenge.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-jake']]) {
                    sh 'echo "=================Terraform Init=================="'
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-jake']]) {
                            sh 'echo "=================Terraform Plan=================="'
                            sh 'terraform plan'
                        }
                    }
                }
            }
        }

        stage('Terraform Apply - Step 1') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-jake']]) {
                            sh 'echo "=================Terraform Apply - Step 1=================="'
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }

        stage('Terraform Apply - Step 2') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-jake']]) {
                            sh 'echo "=================Terraform Apply - Step 2=================="'
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-jake']]) {
                            sh 'echo "=================Terraform Destroy=================="'
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }
}

