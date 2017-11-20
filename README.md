# aws-jenkins-study

[![Build Status](https://travis-ci.org/DennyZhang/aws-jenkins-study.svg?branch=master)](https://travis-ci.org/DennyZhang/aws-jenkins-study) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Slack](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/slack.png)](https://www.dennyzhang.com/slack) [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/aws-jenkins-study/issues) or star [the repo](https://github.com/DennyZhang/aws-jenkins-study).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

Table of Contents
=================

   * [aws-jenkins-study](#aws-jenkins-study)
   * [Scenarios](#scenarios)
      * [Scenario-101: Docker Single-Node Jenkins Deployment I](#scenario-101-docker-single-node-jenkins-deployment-i)
      * [Scenario-102: Docker Single-Node Jenkins Deployment II](#scenario-102-docker-single-node-jenkins-deployment-ii)
      * [Scenario-201: VM Single-Node Jenkins Deployment I](#scenario-201-vm-single-node-jenkins-deployment-i)
      * [Scenario-202: VM Single-Node Jenkins Deployment II](#scenario-202-vm-single-node-jenkins-deployment-ii)
      * [Scenario-301: VM 2-Nodes Jenkins Deployment I](#scenario-301-vm-2-nodes-jenkins-deployment-i)
      * [Scenario-302: VM 2-Nodes Jenkins Deployment II](#scenario-302-vm-2-nodes-jenkins-deployment-ii)
      * [Scenario-401: ECS Jenkins Deployment I](#scenario-401-ecs-jenkins-deployment-i)
      * [Scenario-402: ECS Jenkins Deployment II](#scenario-402-ecs-jenkins-deployment-ii)
   * [Follow Up](#follow-up)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Case study using AWS techstack to setup Jenkins env

# Scenarios

## Scenario-101: Docker Single-Node Jenkins Deployment I
- Objective: Deploy Docker container in AWS
- Requirements:
```
1. Start an EC2 instance by cloudformation
2. Provision the instance as docker daemon
3. Setup Jenkins container inside the instance
```
- Main Tech: Cloudformation, Docker
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: Docker Single-Node Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-101, create a jenkins user by code.
2. Anonymous user can't open the jenkins. Only login user can.
3. When Jenkins is down, get alerts
4. Make sure Jenkins GUI changes can be seamless tracked in git repo.
```
- Main Tech: Cloudformation, Docker
- See more: [Scenario-102](./Scenario-102)

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_aio.png"/> </a>

## Scenario-201: VM Single-Node Jenkins Deployment I
- Objective: We need a live Jenkins env in public Cloud. Fast and easy.
- Requirements:
```
1. Use cloudformation to start an EC2 instance
2. Start Jenkins inside the EC2 instance
```
- Main Tech: Cloudformation, Chef
- See more: [Scenario-201](./Scenario-201)

## Scenario-202: VM Single-Node Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-201, create a jenkins user by code.
2. Anonymous user can't open the jenkins. Only login user can.
3. When Jenkins is down, get slack notification
4. Make sure Jenkins GUI changes can be seamless tracked in git repo.
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch
- See more: [Scenario-202](./Scenario-202)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_aio.png"/> </a>

## Scenario-301: VM 2-Nodes Jenkins Deployment I
- Objective: Avoid SPOF by adding 2 Jenkins instance
- Requirements:
```
1. Start 2 Jenkins instance behind one ALB
2. Enable autoscaling with minimum instance 2 and max 4.
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration, ALB
- See more: [Scenario-301](./Scenario-301)
- TODO

## Scenario-302: VM 2-Nodes Jenkins Deployment II
- Objective: Jenkins cluster deployment
- Requirements:
```
1. Start 1 jenkins master and 1 jenkins slave
2. Enable auto-scaling
3. Customized VPC to allow limited network access
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, EBS, Jenkins Slack Integration, ALB
- See more: [Scenario-302](./Scenario-302)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_2nodes.png"/> </a>

## Scenario-401: ECS Jenkins Deployment I
- Objective: Get exposed to docker orchestration service.
- Requirements:
```
1. Start ECS with 1 node
2. Install a single Jenkins instance
```
- Main Tech: Cloudformation, ECS, EBS
- See more: [Scenario-401](./Scenario-401)
- TODO

## Scenario-402: ECS Jenkins Deployment II
- Objective: Deploy a 2-nodes Jenkins cluster
- Requirements:
```
1. Start ECS with 2 node
2. Start Jenkins service with 2 instances managed by ECS
3. Enable ALB for two Jenkins instances
```
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, ALB
- See more: [Scenario-402](./Scenario-402)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_2nodes.png"/> </a>

# Follow Up
- **Principle**:
```
1. Fully automated. 2. Improve availability
```

- Future Improvements:
```
- TODO: What about backup, and Jenkins two-way sync
- TODO: HA jenkins env
- TODO: How to test customization: multiple kitchen
```

- More Resources:
```
https://github.com/awslabs/startup-kit-templates
https://github.com/awslabs
```

<a href="https://www.dennyzhang.com"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/magic.gif"></a>
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
