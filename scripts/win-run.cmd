@echo off
setlocal enabledelayedexpansion

set files_exist=
if exist Dockerfile (
    if exist docker-compose.yml (
        set files_exist=true
    )
)

if defined files_exist (
    for %%I in (.) do set container_name=%%~nxI
    docker-compose run --service-ports --rm !container_name! /bin/bash
) else (
    echo No Dockerfile or docker-compose.yml found for current directoy %CD%
    echo Run this command directly in the directory containing both Dockerfile and docker-compose.yml
)

endlocal
@echo on
