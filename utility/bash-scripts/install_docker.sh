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
## Updated: Time-stamp: <2017-11-14 10:01:05>
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

mkdir -p ~/log
LOG_FILE="~/log/my_docker.log"

if ! which docker; then
    # TODO: install specific version
    log "Install docker daemon"
    sudo yum install docker -y
else
    log "docker daemon already installed"    
fi
## File: install_docker.sh ends
