pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven_s/w"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/PavithraVD/pro1/'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

            }        
        }
       stage('Generate Test Reports') {
           steps {
               publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])                    }
            }
       stage('Create Docker Image') {
           steps {
               sh 'docker build -t ammu2509/banking-project .'
                    }
                }
       stage('Docker-Login') {
           steps {
               withCredentials([usernamePassword(credentialsId: 'creddockkk', passwordVariable: 'dockerpassword', usernameVariable: 'dockerlogin')]) {
                   sh 'docker login -u ${dockerlogin} -p ${dockerpassword}'
                }
                }
                }
       stage('Push-Image') {
           steps {
               sh 'docker push ammu2509/banking-project .'
                     }
                }
      
}
}
