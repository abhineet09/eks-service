# Running as docker container

    # Docker Build
    docker build -t app -f service/app/docker/Dockerfile service/app

    # Docker Run
    docker run -p 80:5000 -e SERVER_ID=0 app