[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Slack](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/slack.png)](https://www.dennyzhang.com/slack) [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/chef-study/issues) or star [the repo](https://github.com/DennyZhang/chef-study).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Verify Jenkins](#verify-jenkins)
   * [Userful Command](#userful-command)

![scenario-101-screenshot.png](../images/scenario-101-screenshot.png)
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

# Requirements

1. Use cloudformation to start an EC2 instance
2. Start Jenkins inside the EC2 instance
- Get cookbooks
```
docker exec -it my_chef sh

mkdir -p /tmp/berks_cookbooks

cd /tmp/cookbooks/jenkins-demo/
berks vendor /tmp/berks_cookbooks
ls -lth /tmp/berks_cookbooks
```

- Apply Chef update
```
cd /tmp
# From config/node.json, we specify to apply example cookbook
chef-solo -c config/solo.rb -j config/node.json

- After deployment, jenkins is up and running
```

# Verify Jenkins
curl -I http://localhost:8080

# Userful Command
- TODO: cleanup JenkinsUser and JenkinsPassword
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