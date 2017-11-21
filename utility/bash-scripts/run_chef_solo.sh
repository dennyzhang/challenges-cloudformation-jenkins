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
## Updated: Time-stamp: <2017-11-20 22:31:05>
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

function get_community_cookbooks(){
    log "get community cookbooks"
    local berks_cookbook_folder=${1?}
    local cookbook_folder=${2?}
    cd "$cookbook_folder"
    mkdir -p "$berks_cookbook_folder"
    berks vendor "$berks_cookbook_folder"
    ls -lth "$berks_cookbook_folder"
}

function run_chef_solo() {
    local berks_cookbook_folder=${1?}
    local cookbook_folder=${2?}
    local cookbook_name=${3?}
    local node_json_file=${4:-""}

    working_dir="/home/ec2-user/chef"
    parent_cookbook_folder=$(dirname "$cookbook_folder")
    cd "$working_dir"
    # https://github.com/chef-cookbooks/jenkins/issues/659
    # We need to reconfigure cache_path, due to an existing bug with jenkins cookbook
    cat > solo.rb << EOF
cookbook_path ["$parent_cookbook_folder", "$berks_cookbook_folder"]
file_cache_path "/var/chef/cache"
EOF
    if [ -z "$node_json_file" ]; then
    cat > node.json <<EOF
{
  "run_list": ["recipe[$cookbook_name]"]
}
EOF
    node_json_file="${working_dir}/node.json"
    fi
    log "Apply chef-solo update"
    chef-solo --config "${working_dir}/solo.rb" -l debug -L "$LOG_FILE" \
              --force-formatter --no-color --json-attributes "$node_json_file"
}

[ -d /home/ec2-user/log ] || mkdir -p /home/ec2-user/log
LOG_FILE="/home/ec2-user/log/run_chef_solo.log"

cookbook_name=${1?"cookbook name"}
cookbook_folder=${2?"cookbook folder"}
node_json_file=${3:-""}
berks_cookbooks_folder="/tmp/berks_cookbooks"

get_community_cookbooks "$berks_cookbooks_folder" "$cookbook_folder"
run_chef_solo "$berks_cookbooks_folder" "$cookbook_folder" "$cookbook_name" "$node_json_file"
## File: run_chef_solo.sh ends
