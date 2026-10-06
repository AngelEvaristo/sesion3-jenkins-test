pipeline {
    agent {
        label 'windows'
    }
    
    environment {
        DOTNET_VERSION = "9.0"
    }
    
    stages {
        stage('Clone from github'){
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'AngelEvaristo', url: 'https://github.com/AngelEvaristo/sesion3-jenkins-test.git']])
            }
        }
        stage('Validar origen'){
            steps{
                bat 'Esto fue ejecutado desde un JENKINSFILE'
            }
        }
        stage ('Preparar entorno'){
            steps {
                script {
                    echo "Validando version de Dotnet"
                    bat """
                        dotnet --version || echo .NET no encuentrado
                    """
                }
            }
        }
        
        stage('Restaurar dependencias'){
            steps{
                bat 'dotnet restore'
            }
        }
        
        stage('compilacion'){
            steps{
                bat 'dotnet build --configuration Release'
            }
        }
        
        stage('Ejeecutar test'){
            steps {
                bat 'dotnet test --verbosity normal'
            }
        }
        
        stage ('Publicar artefacto'){
            steps{
                bat 'dotnet publish --configuration Release --output publish'
                archiveArtifacts artifacts: 'publish/**', followSymlinks: false
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo "Compilacion completada con exito"
        }
        failure{
            echo "Falla en compilacion"
        }
    }
 
}
