pipeline {
 agent any
 stages {
   stage('Build') {
     steps {
       bat "mvn clean package"
     }
   }
   stage('Test') {
     steps {
       bat "mvn test"
     }
   }
   stage('Deploy') {
    steps {
      bat 'docker compose up -d --build'
    }
   }
 }
}
