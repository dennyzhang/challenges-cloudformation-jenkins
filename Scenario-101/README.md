Table of Contents
=================

   * [Requirements](#requirements)
   * [Procedures](#procedures)

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_aio.png)

# Requirements
1. Start an EC2 instance by cloudformation
2. Provision the instance as docker daemon
3. Setup Jenkins container inside the instance

# Procedures
- Use CF to setup the env
```
    export stack_name="docker-cf-jenkins"
    export tmp_file="file://cf-denny-jenkins-docker-aio.yml"
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
