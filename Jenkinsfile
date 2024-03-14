pipeline {
 agent any
//  tools{
//     maven 'maven'
//  }
 stages {
   stage('Build') {
     steps {
       bat "mvn clean package -DskipTests"
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
