pipeline {
  agent any
  environment {
    registry = "r0g3rc/python-jenkins-app"
    registryCredential = 'dockerhub'
    githubCredential = 'github'
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', credentialsId: githubCredential, url: 'https://github.com/R0g3rG1t/python-docker-jenkins-cicd.git'
      }
    }
    stage('Test') {
      steps {
        sh "pytest test_app.py"
      }
    }
    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build("${registry}:${env.BUILD_ID}")
        }
      }
    }
    stage('Push To DockerHub') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        sh "docker rm -f jenkins-python-app || true"
        sh "docker run -d --name jenkins-python-app -p 5000:5000 ${registry}:${env.BUILD_ID}"
      }
    }
  }
}
