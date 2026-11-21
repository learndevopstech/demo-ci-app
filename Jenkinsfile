pipeline {
  agent any
  parameters {
    string(name: 'THRESHOLD', defaultValue: '80', description: 'Disk usage percent that fails the health check')
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
  }
  post {
    always {
      echo "Build finished: ${currentBuild.currentResult}"
    }
  }
}
