pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-k8s-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/fahmadzia/jenkins-microk8s-app.git', branch: 'main'
            }
        }

        stage('Prepare Kubernetes Files') {
            steps {
                sh 'mkdir -p k8s'
                writeFile file: 'k8s/deployment.yaml', text: '''
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-k8s-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-k8s-app
  template:
    metadata:
      labels:
        app: my-k8s-app
    spec:
      containers:
      - name: my-k8s-app
        image: my-k8s-app:latest
        ports:
        - containerPort: 80
'''
                writeFile file: 'k8s/service.yaml', text: '''
apiVersion: v1
kind: Service
metadata:
  name: my-k8s-service
spec:
  selector:
    app: my-k8s-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
'''
            }
        }

        stage('Deploy to MicroK8s') {
            steps {
                sh '''
                microk8s kubectl apply -f k8s/deployment.yaml
                microk8s kubectl apply -f k8s/service.yaml
                microk8s kubectl rollout status deployment/my-k8s-app
                '''
            }
        }
    }
}
