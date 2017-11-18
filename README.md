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
      * [Scenario-201: VM 2-Nodes Deployment I](#scenario-201-vm-2-nodes-deployment-i)
      * [Scenario-202: VM 2-Nodes Deployment II](#scenario-202-vm-2-nodes-deployment-ii)
      * [Scenario-301: Docker Single-Node Deployment I](#scenario-301-docker-single-node-deployment-i)
      * [Scenario-302: Docker Single-Node Deployment II](#scenario-302-docker-single-node-deployment-ii)
      * [Scenario-401: ECS Single-Node Deployment](#scenario-401-ecs-single-node-deployment)
      * [Scenario-501: ECS 2-Nodes Deployment I](#scenario-501-ecs-2-nodes-deployment-i)
      * [Scenario-502: ECS 2-Nodes Deployment II](#scenario-502-ecs-2-nodes-deployment-ii)
   * [Highlights](#highlights)
   * [Follow Up](#follow-up)
   * [More Resources](#more-resources)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Case study using AWS techstack to setup Jenkins env

# Scenarios

## Scenario-101: VM Single-Node Jenkins Deployment I
- Objective: We need a live Jenkins env in public Cloud. Fast and easy.
- Main Tech: Cloudformation, Chef
- Requirements:
```
1. Use cloudformation to start an EC2 instance
2. Start Jenkins inside the EC2 instance
```
- See more: [Scenario-101](./Scenario-101)
- TODO:

## Scenario-102: VM Single-Node Jenkins Deployment II
- Objective: Besides Scenario-101, add an additional Jenkins user. And enable security and monitoring
- Main Tech: Cloudformation, Chef, VPC, CloudWatch
- See more: [Scenario-102](./Scenario-102)
- Requirements:
```
1. Use cloudformation to start an EC2 instance with Jenkins installed
2. In CF, configure a dedicated VPC. Only one source ip can connect jenkins port(8080)
3. Setup Cloudwatch for Jenkins service. If it's down, send out slack email alert.
```
- TODO

## Scenario-103: VM Single-Node Jenkins Deployment III
- Objective: Besides Scenario-102, get slack notification when Jenkins server is down.
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration
- See more: [Scenario-103](./Scenario-103)
- Requirements:
```
- TODO
```

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_aio.png)

## Scenario-201: VM 2-Nodes Deployment I
- Objective: Avoid SPOF by adding 2 Jenkins instance
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration, ALB
- See more: [Scenario-201](./Scenario-201)
- Requirements:
```
- TODO
```

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_vm_2nodes.png)

## Scenario-202: VM 2-Nodes Deployment II
- Objective: Besides Scenario-106, share volume for Jenkins HOME for 2 instances
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, EBS, Jenkins Slack Integration, ALB
- See more: [Scenario-202](./Scenario-202)
- Requirements:
```
- TODO
```

## Scenario-301: Docker Single-Node Deployment I
- Objective: Immutable infra would be faster and reliable, compared to conf mgmt tool.
- Main Tech: Cloudformation, Docker
- See more: [Scenario-301](./Scenario-301)
- Requirements:
```
- TODO
```

## Scenario-302: Docker Single-Node Deployment II
- Objective: Use docker to deploy customized Jenkins
- Main Tech: Cloudformation, Docker
- See more: [Scenario-302](./Scenario-302)
- Requirements:
```
- TODO
```

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_aio.png)

## Scenario-401: ECS Single-Node Deployment
- Objective: Get exposed to docker orchestration service.
- Main Tech: Cloudformation, ECS, EBS
- See more: [Scenario-401](./Scenario-401)
- Requirements:
```
- TODO
```

## Scenario-501: ECS 2-Nodes Deployment I
- Objective: Deploy 2 nodes Jenkins cluster. With 3 Jenkins instance
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, Lambda, ALB
- See more: [Scenario-501](./Scenario-501)
- Requirements:
```
- TODO
```

![](https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/misc/jenkins_docker_2nodes.png)

## Scenario-502: ECS 2-Nodes Deployment II
- Objective: Deploy Jenkins cluster. Stable: make sure no SPOF. Scalable: when users grow autoscaling take effect
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, Lambda, EFS, ALB
- See more: [Scenario-502](./Scenario-502)
- Requirements:
```
- TODO
```

# Highlights
- **Principle**: 1. Fully automated. 2. Improve availability
- TODO: How to verify deployment quickly: use docker
- TODO: How to verify the Jenkins deployment: use serverspec
- TODO: How to test cluster env: use kitchen converge
- TODO: How to test customization: multiple kitchen

# Follow Up
- TODO: What about backup, and Jenkins two-way sync
- TODO: HA jenkins env

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

<a href="https://www.dennyzhang.com"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/magic.gif"></a>
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
