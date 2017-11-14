#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT
## https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: docker_start_jenkins.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-14>
## Updated: Time-stamp: <2017-11-14 09:14:10>
##-------------------------------------------------------------------
set -e
function log() {
    local msg=$*
    date_timestamp=$(date +['%Y-%m-%d %H:%M:%S'])
    echo -ne "$date_timestamp $msg\n"

    if [ -n "$LOG_FILE" ]; then
        echo -ne "$date_timestamp $msg\n" >> "$LOG_FILE"
    fi
}

function is_container_running(){
    local container_name=${1?}
    if docker ps -a | grep "$container_name" 1>/dev/null 2>/dev/null; then
        if docker ps | grep "$container_name" 1>/dev/null 2>/dev/null; then
            echo "running"
        else
            echo "dead"
        fi
    else
        echo "none"
    fi
}

function start_docker_daemon() {
    if ! service docker status | grep running;then
        # start docker
        log "start docker:"
        service docker start
    fi
}

function docker_pull_image() {
    docker_image=${1?}
    docker pull "$docker_image"
}
################################################################################
function docker_start_jenkins() {
    container_name=${1?}
    container_hostname=${2?}
    docker_image=${3?}
    log "Start docker of $container_name"
    container_status=$(is_container_running "$container_name")

    if [ "$container_status" = "none" ]; then
        command="docker run -p 8080:8080 --name $container_name -h $container_hostname --restart=always $docker_image"
        eval "$command"
    elif [ "$container_status" = "dead" ]; then
        docker start "$container_name"
    fi
}

LOG_FILE="/var/log/my_docker.log"

# Base Docker image: https://github.com/DennyZhang/jenkins_image/blob/master/Dockerfile
docker_image=${1:-"denny/jenkins_image:latest"}
jenkins_container_name=${2:-"my-jenkins"}
jenkins_hostname=${3:-"myjenkins"}

start_docker_daemon
docker_pull_image "$docker_image"
docker_start_jenkins "$jenkins_container_name" "$jenkins_hostname" "$docker_image"
## File: docker_start_jenkins.sh ends
