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
    for /f "tokens=*" %%a in ('docker volume ls --filter name^=!container_name! -q') do set volumes_to_remove=%%a

    if not defined volumes_to_remove (
        echo No volumes to remove
    ) else (
        docker volume rm !volumes_to_remove! --force
    )

) else (
    echo No Dockerfile or docker-compose.yml found for current directory %CD%
    echo Run this command directly in the directory containing both Dockerfile and docker-compose.yml
)

endlocal
@echo on
