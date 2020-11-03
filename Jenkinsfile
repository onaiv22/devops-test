def awsCredentials = [[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'femi-github-cred']]

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
		AWS_PROFILE = 'femi-devop'
		AWS_DEFAULT_REGION = 'eu-west-1'
	}

	stages {

		stage ('Notify deployment start') {
			steps {

			}
		}

		stage ('checkout terraform source code branch') {
			steps {
				checkout([
					$class: 'GitSCM',
					branches: [[name: "*/master"]],
					extensions: [
					[$class: 'CleanCheckout']
				]
				    doGenerateSubmoduleConfigurations: false,
				    submoduleCfg: [],
				    userRemoteConfigs: [
				        [
				            credentialsId: 'femi-github-cred',
				            url: 'https://github.com/onaiv22/devops-test.git'
				        ]
				    ]

				])
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
		stage ('Confirm terraform apply for infra') {
			steps {
				timeout(time:2, unit:'HOURS') {
					input('Please checkout output, do you wish to apply changes?')
				}
			}
		}
		stage ('Run terraform apply for infra') {
			steps {
				dir(path: "devops-test") {
					sh 'terraform apply'
				}
			}
		}
	}
}
