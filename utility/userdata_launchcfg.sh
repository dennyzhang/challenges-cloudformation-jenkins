#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT
## https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: userdata_launchcfg.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-15>
## Updated: Time-stamp: <2017-12-07 15:11:35>
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

function prepare_files() {
    local working_dir=${1?}
    # TODO: reduce the code duplication with cloudformation yaml file
    log "prepare files"
    [ -d "$working_dir" ] || mkdir -p "$working_dir"
    cd "$working_dir"
    # TODO: improve this
    repo_name="chef-study"
    if [ ! -d "$repo_name" ]; then
        wget -O master.tar https://github.com/DennyZhang/chef-study/tarball/master
        tar -xf ./master.tar && rm -rf ./master.tar
        mv DennyZhang-${repo_name}-* "$repo_name"
    fi

    wget -O /home/ec2-user/run_chef_solo.sh https://raw.githubusercontent.com/DennyZhang/challenges-cloudformation-jenkins/master/utility/run_chef_solo.sh
    chown -R ec2-user:ec2-user /home/ec2-user/
}

function install_chef() {
    if ! which chef-solo 1>/dev/null 2>&1; then
        log "Install chef"
        wget -O /tmp/chefdk.rpm \
             https://packages.chef.io/files/stable/chefdk/2.3.4/el/7/chefdk-2.3.4-1.el7.x86_64.rpm
        rpm -ivh /tmp/chefdk.rpm
    fi
}

function run_chef_update() {
    local json_file=${1?}
    local cookbook_path=${2?}
    log "Run chef update"
    bash -ex /home/ec2-user/run_chef_solo.sh "jenkins-demo" \
         "/home/ec2-user/chef/chef-study/${cookbook_path}" \
         "${json_file}"
}

################################################################################
json_file=${1?"node.json file for chef update"}
cookbook_path=${2:?"Jenkins cookbook to run"}
working_dir="/home/ec2-user/chef/"
yum install -y tmux wget tar

prepare_files "$working_dir"
install_chef
run_chef_update "$json_file" "$cookbook_path"
## File: userdata_launchcfg.sh ends
