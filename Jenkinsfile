pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-k8s-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/yourusername/jenkins-microk8s-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                python3 -m venv venv
                source venv/bin/activate
                pip install -r requirements.txt
                '''
            }
        }

        stage('Build and Push to MicroK8s') {
            steps {
                sh '''
                microk8s ctr images ls
                microk8s ctr image import my-k8s-app.tar
                microk8s kubectl apply -f k8s/deployment.yaml
                microk8s kubectl apply -f k8s/service.yaml
                '''
            }
        }

        stage('Deploy to MicroK8s') {
            steps {
                sh 'microk8s kubectl rollout status deployment/my-k8s-app'
            }
        }
    }
}
