[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/challenges-aws-jenkins/issues) or star [the repo](https://github.com/DennyZhang/challenges-aws-jenkins).

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
2. ELB export target group
3. Enable logging for ELB
4. When SNSTopicName is empty, avoid adding SNS notification
```

# Procedures
[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-303.yml)

- Use CF to setup the env

Here we use nested CF, to organize code in small modules.

```
# The IP address range that can be used to Access Jenkins URL
[ -n "$JENKINS_LOCATION" ] || export JENKINS_LOCATION="0.0.0.0/0"
# Slack Token for Jenkins jobs. If empty, no slack notifications
[ -n "$SLACK_TOKEN" ] || export SLACK_TOKEN='CUSTOMIZETHIS'
# ssh key name to access EC2 instance
[ -n "$SSH_KEY_NAME" ] || export SSH_KEY_NAME="YOUR_SSH_KEYNAME_CUSTOMIZE"
[ -n "$SNS_TOPIC_ARN" ] || export SNS_TOPIC_ARN="arn:aws:sns:us-east-1:YOUR_SNS_TOPIC"
bash -ex ./create_stack.sh
```

create_stack.sh: [here](create_stack.sh)

```
export STACK_NAME="aws-jenkins"
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
- Total time estimation: 5 min for AWS resources(AutoScaling group, LB), 13 min for Chef(package, jenkins plugins)
- TODO: enable ThinBackup for config changes
- TODO: fix two jenkins warnings

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

Test fast with Chef
```
docker exec -it jenkins-demo-centos7 bash
rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key.pub
rm -rf /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_dsa_key.pub
exit

docker commit jenkins-demo-centos7 denny/centos_test

export IMAGE_NAME="denny/centos_test"
```
- Cloudformation Wizard

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/challenges-aws-jenkins/master/images/cf_elb_one_master_303.png"/> </a>
