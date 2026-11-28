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
    stage('Docker Push') {
      when { branch 'main' }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                          usernameVariable: 'DH_USER',
                                          passwordVariable: 'DH_PASS')]) {
          sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
          sh 'docker push $IMAGE:$TAG'
          sh 'docker push $IMAGE:latest'
        }
      }
    }
  }
  post {
    always {
      sh 'docker logout || true'
      sh 'docker rmi $IMAGE:$TAG || true'
      sh 'docker image prune -f'
      echo "Build finished: ${currentBuild.currentResult}"
    }
  }
}
