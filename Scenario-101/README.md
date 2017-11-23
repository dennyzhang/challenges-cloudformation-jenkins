Table of Contents
=================

   * [Requirements](#requirements)
   * [Procedures](#procedures)

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_docker_aio.png"/> </a>

# Requirements
1. Start an EC2 instance by cloudformation
2. Provision the instance as docker daemon
3. Setup Jenkins container inside the instance

# Procedures
- Use CF to setup the env
```
    export STACK_NAME="docker-cf-jenkins"
    export TMP_FILE="file://cf-jenkins-101.yml"
    [ -n "$SSH_KEY_NAME" ] || export SSH_KEY_NAME="denny-ssh-key1"
    aws cloudformation create-stack --template-body "$TMP_FILE" \
        --stack-name "$STACK_NAME" --parameters \
        ParameterKey=KeyName,ParameterValue=$SSH_KEY_NAME
```

```
     aws cloudformation delete-stack --stack-name "$STACK_NAME"
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

- Verify Jenkins
curl -I http://$server_ip:8080
