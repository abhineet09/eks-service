# Running as docker container

    # Docker Build
    docker build -t flask-wsgi-app -f docker/Dockerfile app

    # Docker Run
    docker run -p 8080:5000 -e SERVER_ID=0 flask-wsgi-app