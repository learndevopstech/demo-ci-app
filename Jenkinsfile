pipeline {
  agent any
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
    stage('Package') {
      steps {
        sh 'tar -czf healthcheck.tar.gz appp/'
        archiveArtifacts artifacts: 'healthcheck.tar.gz', fingerprint: true
      }
    }
  }
  post {
    always {
      echo "Build finished: ${currentBuild.currentResult}"
    }
  }
}
