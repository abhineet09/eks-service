# Running on Minikube Server 

    # Docker Build 
    eval $(minikube docker-env)

    docker build -t flask-wsgi-app -f docker/Dockerfile app

    # Docker Run - DEBUG ONLY
    docker run -p 8080:5000 -e SERVER_ID=0 flask-wsgi-app

    # Start Minikube Server 
    minikube start --insecure-registry true

    # Create pod
    k apply -f k8s/pod.yaml

    # Create service
    k apply -f k8s/service.yaml

    # Create deployment
    k apply -f k8s/deployment.yaml

    # Access service through minikube
    minikube service app-service --url