#!/bin/bash

if [ -f "Dockerfile" ] && [ -f "docker-compose.yml" ]
then
    container_name=$(basename "$PWD")
    volumes_to_remove=$(docker volume ls --filter name=$container_name -q)

    if [ -z "$volumes_to_remove" ]
    then
        echo 'No volumes to remove'
    else
        docker volume rm $volumes_to_remove --force
    fi
else
    echo 'No Dockerfile or docker-compose.yml found for current directoy' $PWD
    echo 'Run this command directly in the directory containing the Dockerfile and docker-compose.yml'
fi
