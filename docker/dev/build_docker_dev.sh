#!/bin/bash

echo "Build the docker"

docker build . -t rkrispin/covid19italy:dev.0.3.1

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
docker push rkrispin/covid19italy:dev.0.3.1
else
echo "Docker build failed"
fi

