[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Slack](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/slack.png)](https://www.dennyzhang.com/slack) [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/chef-study/issues) or star [the repo](https://github.com/DennyZhang/chef-study).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Procedures](#procedures)

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_aio.png)

# Requirements
1. Finish Scenario-201, create a jenkins user by code.
2. Anonymous user can't open the jenkins. Only login user can.
3. When Jenkins is down, get slack notification
4. Make sure Jenkins GUI changes can be seamless tracked in git repo.

# Procedures
- Use CF to setup the env
```
    export stack_name="docker-cf-jenkins"
    export tmp_file="file://cf-denny-jenkins-vm-aio.yml"
    aws cloudformation create-stack --template-body "$tmp_file" \
        --stack-name "$stack_name" --parameters \
        ParameterKey=JenkinsUser,ParameterValue=username \
        ParameterKey=JenkinsPassword,ParameterValue=mypassword \
        ParameterKey=KeyName,ParameterValue=denny-ssh-key1

     aws cloudformation delete-stack --stack-name "$stack_name"
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

- Verify Jenkins
curl -I http://$server_ip:8080
