pipeline {
    agent any

    parameters {
        choice(name: 'BRANCH', choices: ['main','develop'], description: 'Seleccionar rama')
        booleanParam(name: 'RUNTEST', defaultValue: true, description: 'Desea ejecutar pruebas')
    }    
    
    environment {
        DOTNET_VERSION = "9.0"
    }
    
    stages {
        stage('Clone from github'){
            steps {
                checkout scmGit(branches: [[name: "*/${params.BRANCH}"]], extensions: [], userRemoteConfigs: [[credentialsId: 'AngelEvaristo', url: 'https://github.com/AngelEvaristo/sesion3-jenkins-test.git']])
            }
        }
        stage('Validar origen'){
            steps{
                echo 'Esto fue ejecutado desde un JENKINSFILE'
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
        
        stage('Ejecutar test'){
            when {
                expression { params.RUNTEST }                            
            }    
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
            echo "Compilacion completada con exito, disparando proyecto"
            build job: 'pipeline_estilolibre'
        }
        failure{
            echo "Falla en compilacion"
        }
    }
 
}
