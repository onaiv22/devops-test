pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '6'))
        skipStagesAfterUnstable()
    }

    environment {
        buildstatus = '0'
        AWS_ACCESS_KEY_ID = credentials('aws-credentials-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials-id')
        AWS_DEFAULT_REGION = 'eu-west-1'
        AWS_PROFILE_NAME = 'default'
    }

    stages {
        stage('Install AWS CLI') {
            steps {
                sh '''
                    # Install AWS CLI if not already installed
                    if ! command -v aws &> /dev/null
                    then
                        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                        unzip awscliv2.zip
                        sudo ./aws/install
                    fi
                '''
            }
        }
        stage('Configure AWS CLI Profile') {
            steps {
                sh '''
                    if ! aws configure list-profiles | grep -q ${AWS_PROFILE_NAME}
                    then
                        aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID} --profile ${AWS_PROFILE_NAME}
                        aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY} --profile ${AWS_PROFILE_NAME}
                        aws configure set region ${AWS_DEFAULT_REGION} --profile ${AWS_PROFILE_NAME}
                    else
                        echo "AWS CLI profile '${AWS_PROFILE_NAME}' already exists. Skipping configuration."
                    fi
                '''
            }
        }
        stage('Checkout Code') {
            steps {
                // Clone the public repository
                git url: 'https://github.com/onaiv22/devops-test.git'
            }
        }
        stage('Run terraform init') {
            steps {
                ansiColor('xterm') {
                    sh 'terraform init'
                }
            }
        }
        stage('Run terraform plan') {
            steps {
                ansiColor('xterm') {
                    sh '''
                        terraform plan \
                        -var "aws_access_key_id=${AWS_ACCESS_KEY_ID}" \
                        -var "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" \
                        -var "aws_region=${AWS_DEFAULT_REGION}"
                    '''
                }
            }
        }
    }
}
