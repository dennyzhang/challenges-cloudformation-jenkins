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
## Updated: Time-stamp: <2017-11-18 23:20:51>
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

function get_community_cookbook(){
    log "get community cookbook"
    berks_cookbook_folder=${1?}
    cookbook_folder=${2?}
    cd "$cookbook_folder"
    mkdir -p "$berks_cookbook_folder"
    berks vendor "$berks_cookbook_folder"
    ls -lth "$berks_cookbook_folder"
}

function run_chef_solo() {
    berks_cookbook_folder=${1?}
    cookbook_folder=${2?}
    cookbook_name=${3?}
    working_dir="/home/ec2-user/chef"
    cd "$working_dir"
    cat > solo.rb << EOF
cookbook_path [File.expand_path(File.join('$cookbook_folder', '..')), '$berks_cookbook_folder']
EOF
    cat > node.json <<EOF
{
  "run_list": [ "recipe[$cookbook_name]" ]
}
EOF
    log "Apply chef update: chef-solo -c solo.rb -j node.json"
    sudo chef-solo -L "$LOG_FILE" -c solo.rb -j node.json
}

[ -d /home/ec2-user/log ] || mkdir -p /home/ec2-user/log
LOG_FILE="/home/ec2-user/log/run_chef_solo.log"

cookbook_name=${1?"cookbook name"}
cookbook_folder=${2?"cookbook folder"}
berks_cookbooks_folder="/tmp/berks_cookbooks"

get_community_cookbook "$berks_cookbooks_folder" "$cookbook_folder"
run_chef_solo "$berks_cookbooks_folder" "$cookbook_folder" "$cookbook_name"
## File: run_chef_solo.sh ends
