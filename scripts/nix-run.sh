#!/bin/bash

if [ -f "Dockerfile" ] && [ -f "docker-compose.yml" ]
then
    container_name=$(basename "$PWD")
    docker-compose run --service-ports --rm $container_name /bin/bash
else
    echo 'No Dockerfile or docker-compose.yml found for current directory' $PWD
    echo 'Run this command directly in the directory containing the Dockerfile and docker-compose.yml'
fi
