# Running as docker container

    # Docker Build
    docker build -t backend -f service/backend/docker/Dockerfile service/backend

    # Docker Run
    docker run -e SERVER_ID=1 backend