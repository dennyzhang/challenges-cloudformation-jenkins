[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/chef-study/issues) or star [the repo](https://github.com/DennyZhang/chef-study).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Procedures](#procedures)

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_vm_aio.png"/> </a>

# Requirements
1. Finish Scenario-202
2. Enable CloudWatch monitoring for Jenkins
3. When Jenkins is down, get slack notification
4. In case Jenkins master crash, create an auto-scaling group. And configure the instance count as 1

# Procedures
[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-203.yml)

- Use CF to setup the env
```
export STACK_NAME="aws-jenkins"
export TMP_FILE="file://cf-jenkins-203.yml"

# The IP address range that can be used to Access Jenkins URL
[ -n "$JENKINS_LOCATION" ] || export JENKINS_LOCATION="0.0.0.0/0"
# Test jenkins username and password
export JENKINS_USER="jenkins123"
export JENKINS_PASSWORD="password123"
[ -n "$JENKINS_PORT" ] || export JENKINS_PORT='8081'

# Slack Token for Jenkins jobs. If empty, no slack notifications
[ -n "$SLACK_TOKEN" ] || export SLACK_TOKEN='CUSTOMIZETHIS'
# ssh key name to access EC2 instance
[ -n "$SSH_KEY_NAME" ] || export SSH_KEY_NAME="denny-ssh-key1"

aws cloudformation create-stack --template-body "$TMP_FILE" \
    --stack-name "$STACK_NAME" --parameters \
    ParameterKey=JenkinsUser,ParameterValue=$JENKINS_USER \
    ParameterKey=JenkinsPassword,ParameterValue=$JENKINS_PASSWORD \
    ParameterKey=SlackAuthToken,ParameterValue=$SLACK_TOKEN \
    ParameterKey=JenkinsLocation,ParameterValue=$JENKINS_LOCATION \
    ParameterKey=JenkinsPort,ParameterValue=$JENKINS_PORT \
    ParameterKey=KeyName,ParameterValue=$SSH_KEY_NAME
```

```
aws cloudformation delete-stack --stack-name "$STACK_NAME"
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

- Verify Jenkins
curl -I http://$server_ip:8080

TODO: enable ThinBackup for config changes

TODO: remove two jenkins warnings

```
Allowing Jenkins CLI to work in -remoting mode is considered
dangerous and usually unnecessary. You are advised to disable this
mode. Please refer to the CLI documentation for details.

Agent to master security subsystem is currently off. Please read the
documentation and consider turning it on
```