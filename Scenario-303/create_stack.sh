#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: create_stack.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-27>
## Updated: Time-stamp: <2017-11-27 10:12:31>
##-------------------------------------------------------------------
export STACK_NAME="aws-jenkins"
# Test jenkins username and password
export JENKINS_USER="jenkins123"
export JENKINS_PASSWD="password123"
[ -n "$JENKINS_PORT" ] || export JENKINS_PORT='8081'
[ -n "$SIZE_DESIRED" ] || export SIZE_DESIRED="1"
[ -n "$SIZE_MIN" ] || export SIZE_MIN="1"

export TMP_FILE="file://cf-jenkins-main-303.yml"
# Start cloudformation stack
aws cloudformation create-stack --template-body "$TMP_FILE" \
    --stack-name "$STACK_NAME" --parameters \
    ParameterKey=JenkinsTestUser,ParameterValue=$JENKINS_USER \
    ParameterKey=JenkinsTestPasswd,ParameterValue=$JENKINS_PASSWD \
    ParameterKey=SlackAuthToken,ParameterValue=$SLACK_TOKEN \
    ParameterKey=JenkinsLocation,ParameterValue=$JENKINS_LOCATION \
    ParameterKey=JenkinsPort,ParameterValue=$JENKINS_PORT \
    ParameterKey=KeyName,ParameterValue=$SSH_KEY_NAME \
    ParameterKey=SizeDesired,ParameterValue=$SIZE_DESIRED \
    ParameterKey=SizeMin,ParameterValue=$SIZE_MIN \
    ParameterKey=SNSTopicARN,ParameterValue=$SNS_TOPIC_ARN
## File: create_stack.sh ends
