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
                office365ConnectorSend( message: "<p>Deploying terraform from master branch to aws environments</br>URL: <a href=\"${env.BUILD_URL}\">Jenkins Build</a></p>",
                    status: "Started",
                    color: "AC33FF",
                    webhookUrl: "https://outlook.office.com/webhook/7f87d50c-7b5d-4b3f-b776-bc88c2c6353b@e11fd634-26b5-47f4-8b8c-908e466e9bdf/JenkinsCI/d8378fcc4ebb4e9b9fa52e0822a1a1a2/596dfa6a-54cb-45f5-b31a-d14c61a72156"
                )
            }
        }
        stage ('Checkout terraform source code branch') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "*/master"]],
                    extensions: [
                    [$class: 'CleanCheckout']
                ],
                    doGenerateSubmoduleConfigurations: false,
                    submoduleCfg: [],
                    userRemoteConfigs: [
                        [
                            credentialsId: 'git-signin',
                            url: 'https://github.com/onaiv22/devops-test.git'
                        ]
                    ]
                ])
            }
        }
        stage ('Run terraform plan') {
            steps {
                dir(path: "devops-test") {
                    sh """#! /usr/bin/env bash
                        export PATH=${workspace}/bin:\${PATH}

                        echo "Running terraform plan"
                        terraform plan
                    """
                }
            }
        }
        stage('Confirm terraform apply for infrastructure') {
            steps {
                timeout(time:2, unit:'HOURS') {
                    input('Please check the plan output, do you wish to apply these changes?')
                }
            }
        }
        stage ('Run terraform apply for dev') {
            steps {
                dir(path: "devops-test") {
                    sh """#! /usr/bin/env bash
                        export PATH=${workspace}/bin:\${PATH}

                        echo "Running terraform apply"
                        terraform apply -y
                    """
                }
            }
        }
        post {
        success {
            office365ConnectorSend( message: "<p>Deployed terraform from master branch to aws environments.</br>URL: <a href=\"${env.BUILD_URL}\">Jenkins Build</a></p>",
                status: "Deployment Succeeded",
                color: "00FF00",
                webhookUrl: "https://outlook.office.com/webhook/7f87d50c-7b5d-4b3f-b776-bc88c2c6353b@e11fd634-26b5-47f4-8b8c-908e466e9bdf/JenkinsCI/d8378fcc4ebb4e9b9fa52e0822a1a1a2/596dfa6a-54cb-45f5-b31a-d14c61a72156"
            )
        }
        failure {
            office365ConnectorSend( message: "<p>Failed deploying terraform from master branch to aws environments.</br>URL: <a href=\"${env.BUILD_URL}\">Jenkins Build</a></p>",
                status: "Deployment Failed",
                color: "FF0000",
                webhookUrl: "https://outlook.office.com/webhook/7f87d50c-7b5d-4b3f-b776-bc88c2c6353b@e11fd634-26b5-47f4-8b8c-908e466e9bdf/JenkinsCI/d8378fcc4ebb4e9b9fa52e0822a1a1a2/596dfa6a-54cb-45f5-b31a-d14c61a72156"
            )
        }
        aborted {
            office365ConnectorSend(  message: "<p>Aborted Ddeploying terraform from master branch to aws environments.</br>URL: <a href=\"${env.BUILD_URL}\">Jenkins Build</a></p>",
                status: "Deployment Aborted",
                color: "FF0000",
                webhookUrl: "https://outlook.office.com/webhook/7f87d50c-7b5d-4b3f-b776-bc88c2c6353b@e11fd634-26b5-47f4-8b8c-908e466e9bdf/JenkinsCI/d8378fcc4ebb4e9b9fa52e0822a1a1a2/596dfa6a-54cb-45f5-b31a-d14c61a72156"
            )
        }
    }
}
