pipeline {
  agent any
  parameters {
    string(name: 'THRESHOLD', defaultValue: '80', description: 'Disk usage percent that fails the health check')
  }
  environment {
    IMAGE = 'learndevopstech/demo-ci-app'
    TAG   = "${env.BUILD_NUMBER}"
  }
  stages {
    stage('Lint') {
      steps {
        sh 'bash -n app/healthcheck.sh'
      }
    }
    stage('Test') {
      steps {
        sh 'bash tests/test_healthcheck.sh'
      }
    }
    stage('Health check') {
      steps {
        sh "bash app/healthcheck.sh ${params.THRESHOLD}"
      }
    }
    stage('Package') {
      steps {
        sh 'tar -czf healthcheck.tar.gz app/'
        archiveArtifacts artifacts: 'healthcheck.tar.gz', fingerprint: true
      }
    }
    stage('Docker Build') {
      steps {
        sh 'docker build -t $IMAGE:$TAG -t $IMAGE:latest .'
      }
    }
    stage('Docker Test') {
      steps {
        sh 'docker run --rm --entrypoint bash $IMAGE:$TAG tests/test_healthcheck.sh'
        sh 'docker run --rm $IMAGE:$TAG 100'
      }
    }
  }
  post {
    always {
      echo "Build finished: ${currentBuild.currentResult}"
    }
  }
}
