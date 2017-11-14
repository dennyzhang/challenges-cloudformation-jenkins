#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: install_docker.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-14>
## Updated: Time-stamp: <2017-11-14 10:30:00>
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

[ -d /home/ec2-user/log ] || mkdir -p /home/ec2-user/log
LOG_FILE="/home/ec2-user/log/my_docker.log"

if ! which docker; then
    # TODO: install specific version
    log "Install docker daemon"
    sudo yum install docker -y
    sudo usermod -a -G docker ec2-user
    sudo service docker start
else
    log "docker daemon already installed"    
fi
## File: install_docker.sh ends
