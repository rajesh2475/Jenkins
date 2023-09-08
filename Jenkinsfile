pipeline {
    agent any 
    environment {
      regDomainName = '<regDomainName>'
      reg = "${regDomainName}/<path>"
      dockerImage = "${reg}" + ":$BUILD_NUMBER"
      regCreds = "<name-creds-stored-in-jenkins-global-creds>"
    }
    stages {
        stage('Clone git code') {
            steps {
                git branch '<branch-name>', url: '<git-url>'
                
            }
        }
        stage('Unittest') {
            steps {
                sh('bash ./jenkins_script.sh')
            }
        }
        stage('code coverage') {
            steps {
                junit skipMarkingBuildUnstable:true, testResults: "<UT Result File Path>"
                coberture cobertureReportFile: "coverage*.xml"
            }
        }
        stage('Build') {
            steps {
                dockerImg = docker.build("${dockerImage}")
            }
        }
        stage('Push to reg') {
            steps {
                docker.withRegistry("https://${regDomainName}", regCreds){
                  dockerImg.push()
                }
            }
          post {
            success {
              sh "docker rmi ${dockerImage}:
            }
          }
        }
    }
}
