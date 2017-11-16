#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: run_chef_solo.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-15>
## Updated: Time-stamp: <2017-11-15 23:57:16>
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

# TODO: customize this
cookbook_name=${1:-"jenkins-demo-101"}

cookbook_folder="/home/ec2-user/${cookbook_name}"
berks_cookbook_folder="/tmp/berks_cookbooks"
mkdir -p "$cookbook_folder"

cd "$cookbook_folder/"
berks vendor "$berks_cookbook_folder"
ls -lth "$berks_cookbook_folder"
## File: run_chef_solo.sh ends
