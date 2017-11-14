# aws-jenkins-study

[![Build Status](https://travis-ci.org/DennyZhang/aws-jenkins-study.svg?branch=master)](https://travis-ci.org/DennyZhang/aws-jenkins-study) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Slack](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/slack.png)](https://www.dennyzhang.com/slack) [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/aws-jenkins-study/issues) or star [the repo](https://github.com/DennyZhang/aws-jenkins-study).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

Table of Contents
=================

   * [aws-jenkins-study](#aws-jenkins-study)
   * [Scenarios](#scenarios)
      * [Scenario-101: VM Single-Node Jenkins Deployment I](#scenario-101-vm-single-node-jenkins-deployment-i)
      * [Scenario-102: VM Single-Node Jenkins Deployment II](#scenario-102-vm-single-node-jenkins-deployment-ii)
      * [Scenario-103: VM Single-Node Jenkins Deployment III](#scenario-103-vm-single-node-jenkins-deployment-iii)
      * [Scenario-104: Docker Single-Node Deployment I](#scenario-104-docker-single-node-deployment-i)
      * [Scenario-105: Docker Single-Node Deployment II](#scenario-105-docker-single-node-deployment-ii)
      * [Scenario-106: ECS Single-Node Deployment](#scenario-106-ecs-single-node-deployment)
      * [Scenario-107: VM 2-Nodes Deployment I](#scenario-107-vm-2-nodes-deployment-i)
      * [Scenario-108: VM 2-Nodes Deployment II](#scenario-108-vm-2-nodes-deployment-ii)
      * [Scenario-109: ECS 2-Nodes Deployment I](#scenario-109-ecs-2-nodes-deployment-i)
      * [Scenario-110: ECS 2-Nodes Deployment II](#scenario-110-ecs-2-nodes-deployment-ii)
   * [Highlights](#highlights)
   * [Follow Up](#follow-up)
   * [Useful Commands](#useful-commands)
   * [More Resources](#more-resources)
   * [License](#license)

Case study using AWS techstack to setup Jenkins env

# Scenarios

## Scenario-101: VM Single-Node Jenkins Deployment I
- Objective: We need a live Jenkins env in public Cloud. Fast and easy.
- Main Tech: Cloudformation, Chef

## Scenario-102: VM Single-Node Jenkins Deployment II
- Objective: Besides Scenario-101, add an additional Jenkins user. And enable security and monitoring
- Main Tech: Cloudformation, Chef, VPC, CloudWatch

## Scenario-103: VM Single-Node Jenkins Deployment III
- Objective: Besides Scenario-102, get slack notification when Jenkins server is down.
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_aio.png)

## Scenario-104: Docker Single-Node Deployment I
- Objective: Immutable infra would be faster and reliable, compared to conf mgmt tool.
- Main Tech: Cloudformation, Docker

## Scenario-105: Docker Single-Node Deployment II
- Objective: Use docker to deploy customized Jenkins
- Main Tech: Cloudformation, Docker

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_aio.png)

## Scenario-106: ECS Single-Node Deployment
- Objective: Get exposed to docker orchestration service.
- Main Tech: Cloudformation, ECS, EBS

## Scenario-107: VM 2-Nodes Deployment I
- Objective: Avoid SPOF by adding 2 Jenkins instance
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration, ALB

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_2nodes.png)

## Scenario-108: VM 2-Nodes Deployment II
- Objective: Besides Scenario-106, share volume for Jenkins HOME for 2 instances
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, EBS, Jenkins Slack Integration, ALB

## Scenario-109: ECS 2-Nodes Deployment I
- Objective: Deploy 2 nodes Jenkins cluster. With 3 Jenkins instance
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, Lambda, ALB

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_2nodes.png)

## Scenario-110: ECS 2-Nodes Deployment II
- Objective: Deploy Jenkins cluster. Stable: make sure no SPOF. Scalable: when users grow autoscaling take effect
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, Lambda, EFS, ALB

# Highlights
- **Principle**: 1. Fully automated. 2. Improve availability
- TODO: How to verify deployment quickly: use docker
- TODO: How to verify the Jenkins deployment: use serverspec
- TODO: How to test cluster env: use kitchen converge
- TODO: How to test customization: multiple kitchen

# Follow Up
- TODO: What about backup, and Jenkins two-way sync
- TODO: HA jenkins env

# Useful Commands
- Upload CF yaml files to AWS S3

```
s3cmd put cf-denny-jenkins-docker-aio.yml  s3://aws.dennyzhang.com/

https://s3.amazonaws.com/aws.dennyzhang.com/cf-denny-jenkins-docker-aio.yml
```
- Use aws cli to create cloudformation stack

```
aws cloudformation create-stack --template-body file://templates/single_instance.yml \
    --stack-name docker-cf-jenkins --parameters \
    ParameterKey=KeyName,ParameterValue=tutorial \
    ParameterKey=InstanceType,ParameterValue=t2.micro
```

```
aws cloudformation delete-stack --stack-name docker-cf-jenkins
```

# More Resources
- https://github.com/awslabs/startup-kit-templates
- https://github.com/awslabs

Misc Requirements

Setup Jenkins in AWS using cloud formation and your favorite config mgmt tool(Chef/Puppet)
- Use cloud formation start EC2 VM
- Use Chef to deploy Jenkins instance
- Jenkins install sample jobs
- [Optional] Setup ELB/ASG
- [Optional] Security Hardening
- [Optional] Monitoring/Alerting

- TODO: create a minibook from this project
- TODO: Update main doc for the detail requirements

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/magic.gif">
