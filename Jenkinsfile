pipeline {
    agent any

	options {
		disableConcurrentBuilds()
		ansiColor('xterm')
		buildDiscarder(logRotator(numToKeepStr: '6'))
		skipStagesAfterUnstable()
	}

	environment {
		buildstatus = 0
		AWS_ACCESS_KEY_ID = credentials('aws-credentials-id:AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials-id:AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'eu-west-2'   
	}    
    stages {
        stage('Checkout Code') {
            steps {
                // Clone the public repository
                git url: 'https://github.com/onaiv22/devops-test.git'
            }
        }
		stage ('Run terraform init') {
			steps {
				dir(path: "devops-test") {
					sh 'terraform init'
				}
			}
		}
		stage ('Run terraform plan') {
			steps {
				dir(path: "devops-test") {
					sh 'terraform plan'
				}
			}
		}
    }
}
