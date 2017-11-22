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
## Updated: Time-stamp: <2017-11-22 15:02:22>
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
    wget -O master.tar https://github.com/DennyZhang/chef-study/tarball/master
    tar -xf master.tar
    mv DennyZhang-chef-study-* DennyZhang-chef-study

    wget -O /home/ec2-user/run_chef_solo.sh https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/utility/bash-scripts/run_chef_solo.sh
    # TODO: how to pass the parameters?
    # The IP address range that can be used to Access Jenkins URL
    [ -n "$JENKINS_LOCATION" ] || export JENKINS_LOCATION="0.0.0.0/0"
    # Test jenkins username and password
    export JENKINS_USER="jenkins123"
    export JENKINS_PASSWORD="password123"
    [ -n "$JENKINS_PORT" ] || export JENKINS_PORT='8081'

    # Slack Token for Jenkins jobs. If empty, no slack notifications
    [ -n "$SLACK_TOKEN" ] || export SLACK_TOKEN='CUSTOMIZETHIS'

    cat > /home/ec2-user/chef/node.json << EOF
                {"jenkins_demo":
                  {"jenkins_port":"${JenkinsPort}",
                  "default_username":"${JenkinsUser}",
                   "default_password":"${JenkinsPassword}",
                   "jenkins_jobs":"CommonServerCheckRepo",
                   "slack_authtoken":"${SlackAuthToken}",
                   "slack_teamdomain":"mywechat",
                   "slack_buildserverurl":"http://localhost:${JenkinsPort}/",
                   "slack_room":"#denny-alerts"
                   },
                 "run_list":["recipe[apt::default]",
                             "recipe[jenkins-demo::default]",
                             "recipe[jenkins-demo::conf_job]"
                            ]
                }
EOF
    chown -R ec2-user:ec2-user /home/ec2-user/
}

function install_chef() {
    log "Install chef"
    wget -O /tmp/chefdk.rpm \
         https://packages.chef.io/files/stable/chefdk/2.3.4/el/7/chefdk-2.3.4-1.el7.x86_64.rpm
    rpm -ivh /tmp/chefdk.rpm
}

function run_chef_update() {
    log "Run chef update"
    cookbook_path="Scenario-302/cookbooks/jenkins-demo"
    bash -ex /home/ec2-user/run_chef_solo.sh "jenkins-demo" \
         "/home/ec2-user/chef/chef-study/${cookbook_path}" \
         "/home/ec2-user/chef/node.json"
}

################################################################################
working_dir="/home/ec2-user/chef/"
yum install -y tmux wget tar

prepare_files "$working_dir"
install_chef
run_chef_update
## File: userdata_launchcfg.sh ends
