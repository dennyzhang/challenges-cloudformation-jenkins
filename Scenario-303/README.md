[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/chef-study/issues) or star [the repo](https://github.com/DennyZhang/chef-study).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="300" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Procedures](#procedures)
   * [Verifications](#verifications)
   * [Highlights](#highlights)

# Requirements
```
1. Finish Scenario-302
2. ELB export EC2 instance resource
3. Enable logging for ELB
```

# Procedures
[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-303.yml)

- Use CF to setup the env

Here we use nested CF, to organize code in small modules.

```
export STACK_NAME="aws-jenkins"
# The IP address range that can be used to Access Jenkins URL
[ -n "$JENKINS_LOCATION" ] || export JENKINS_LOCATION="0.0.0.0/0"
# Test jenkins username and password
export JENKINS_USER="jenkins123"
export JENKINS_PASSWD="password123"
[ -n "$JENKINS_PORT" ] || export JENKINS_PORT='8081'

# Slack Token for Jenkins jobs. If empty, no slack notifications
[ -n "$SLACK_TOKEN" ] || export SLACK_TOKEN='CUSTOMIZETHIS'
# ssh key name to access EC2 instance
[ -n "$SSH_KEY_NAME" ] || export SSH_KEY_NAME="YOUR_SSH_KEYNAME_CUSTOMIZE"
[ -n "$SNS_TOPIC_ARN" ] || export SNS_TOPIC_ARN="arn:aws:sns:us-east-1:YOUR_SNS_TOPIC"
[ -n "$SIZE_DESIRED" ] || export SIZE_DESIRED="1"
[ -n "$SIZE_MIN" ] || export SIZE_MIN="1"
```

```
export TMP_FILE="file://cf-jenkins-main-303.yml"
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
```

```
aws cloudformation delete-stack --stack-name "$STACK_NAME"
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>


# Verifications

- How to test autoscaling

```
1. We now only have one Jenkins master instance. Terminate the instance.
2. We shall get one slack notification about the temrination.
3. Very soon, we shall get another slack notification about launching a new EC2 instance
```

- How to monitoring

```
1. Login to instance and shutdown jenkins service
2. We shall slack notification from ELB-5XX metric
3. Start jenkins, it shall return to normal
```

# Highlights
- Provision Loadbalancer would take minutes
- TODO: enable ThinBackup for config changes
- TODO: remove two jenkins warnings

```
Allowing Jenkins CLI to work in -remoting mode is considered
dangerous and usually unnecessary. You are advised to disable this
mode. Please refer to the CLI documentation for details.

Agent to master security subsystem is currently off. Please read the
documentation and consider turning it on
```

- Useful Commands
```
s3cmd put "cf-jenkins-elb-303.yml" s3://aws.dennyzhang.com/

dns_url=http://aws-jenkins-elb-kcnzdkirty1x-2072597276.us-east-1.elb.amazonaws.com
for((i=0; i< 10; i++)); do { curl -I "$dns_url"; sleep 1 ;}; done
```

- Cloudformation Wizard

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/cf_elb_one_master.png"/> </a>
