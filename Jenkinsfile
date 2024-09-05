pipeline {
    agent any
    stages {
        stage('Build Project') {
            steps {
                git url: 'https://github.com/PavithraVD/pro1/', branch: 'master'
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ammu2509/staragileprojectfinance:v1 .'
                    sh 'docker images'
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                script {
                    sh 'sudo docker run -itd --name My-first-container -p 8090:8081 ammu2509/staragileprojectfinance:v1'
                }
            }
        }
        stage('Config & Deployment with Terraform') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                  accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY', 
                                  credentialsId: 'AwsAccessKey']]) {
                    dir('terraform-files') {
                        sh 'sudo chmod 600 tomcat.pem'
                        sh 'terraform init'
                        sh 'terraform validate'
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
    }
}
