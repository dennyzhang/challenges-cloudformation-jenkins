# aws-jenkins-study

[![Build Status](https://travis-ci.org/DennyZhang/aws-jenkins-study.svg?branch=master)](https://travis-ci.org/DennyZhang/aws-jenkins-study) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

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
      * [Scenario-203: VM Single-Node Jenkins Deployment III](#scenario-203-vm-single-node-jenkins-deployment-iii)
      * [Scenario-301: VM ASG/ELB Jenkins Deployment I](#scenario-301-vm-asgelb-jenkins-deployment-i)
      * [Scenario-401: VM 2-Nodes Jenkins Deployment I](#scenario-401-vm-2-nodes-jenkins-deployment-i)
      * [Scenario-402: VM 2-Nodes Jenkins Deployment II](#scenario-402-vm-2-nodes-jenkins-deployment-ii)
      * [Scenario-501: ECS Jenkins Deployment I](#scenario-501-ecs-jenkins-deployment-i)
      * [Scenario-502: ECS Jenkins Deployment II](#scenario-502-ecs-jenkins-deployment-ii)
      * [Scenario-503: ECS Jenkins Deployment III](#scenario-503-ecs-jenkins-deployment-iii)
      * [Scenario-601: Large Scale Jenkins Deployment I](#scenario-601-large-scale-jenkins-deployment-i)
   * [Highlights](#highlights)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Case study using AWS TechStack to setup Jenkins env

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

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-101.yml)
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: Docker Single-Node Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-101, create a jenkins user by code.
2. Anonymous user can't open the jenkins. Only login user can.
3. When Jenkins is down, get alerts
4. Make sure Jenkins GUI changes can be seamlessly tracked in git repo.
```
- Main Tech: Cloudformation, Docker

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-102.yml)
- See more: [Scenario-102](./Scenario-102)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_docker_aio.png"/> </a>

## Scenario-201: VM Single-Node Jenkins Deployment I
- Objective: We need a live Jenkins env in public Cloud. Fast and easy.
- Requirements:
```
1. Use cloudformation to start an EC2 instance
2. Start Jenkins inside the EC2 instance
```
- Main Tech: Cloudformation, Chef

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-201.yml)
- See more: [Scenario-201](./Scenario-201)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

## Scenario-202: VM Single-Node Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-201, create a jenkins user by code.
2. Create a dedicated VPC for the jenkins. And allow selective source IP to access.
3. Anonymous user can't open the jenkins. Only login user can.
4. Make sure Jenkins GUI changes can be seamlessly tracked in git repo.
```
- Main Tech: Cloudformation, Chef, VPC, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-202.yml)
- See more: [Scenario-202](./Scenario-202)

## Scenario-203: VM Single-Node Jenkins Deployment III
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-202
2. Use CF to create a dedicated VPC and start an EC2
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-203.yml)
- See more: [Scenario-203](./Scenario-203)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_vm_aio.png"/> </a>

## Scenario-301: VM ASG/ELB Jenkins Deployment I
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Use CF to create ASG and ELB. And monitor ELB
2. Start Jenkins master by ELB. Configure instance count to 1
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-301.yml)
- See more: [Scenario-301](./Scenario-301)
- TODO

## Scenario-401: VM 2-Nodes Jenkins Deployment I
- Objective: Avoid SPOF by adding 2 Jenkins instance
- Requirements:
```
1. Start 1 jenkins master and 1 jenkins slave
2. Jenkins master offload request to jenkins slave
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-401.yml)
- See more: [Scenario-401](./Scenario-401)
- TODO
- TODO: how the 2 Jenkins instance gonna to coordinate with each other?

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

## Scenario-402: VM 2-Nodes Jenkins Deployment II
- Objective: Jenkins cluster deployment
- Requirements:
```
1. Start 1 jenkins master and 1 jenkins slave
2. Enable auto-scaling for Jenkins master. With instance count 1
3. Enable auto-scaling for Jenkins slaves. With instance count range from 1 to 3
4. Customized VPC to allow limited network access
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, EBS, Jenkins Slack Integration, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-402.yml)
- See more: [Scenario-402](./Scenario-402)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_vm_2nodes.png"/> </a>

## Scenario-501: ECS Jenkins Deployment I
- Objective: Get exposed to docker orchestration service.
- Requirements:
```
1. Start ECS with 1 node
2. Install a single Jenkins instance
```
- Main Tech: Cloudformation, ECS, EBS

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-501.yml)
- See more: [Scenario-501](./Scenario-501)
- TODO

## Scenario-502: ECS Jenkins Deployment II
- Objective: Deploy a 2-nodes Jenkins cluster
- Requirements:
```
1. Start ECS with 2 node
2. Start Jenkins service with 2 instances in ECS. One for master, one for slave.
3. Enable ALB for Jenkins master
```
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-502.yml)
- See more: [Scenario-502](./Scenario-502)
- TODO
- TODO: How to avoid Jenkins SPOF, theoretically speaking?

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_ecs_2nodes.png"/> </a>

## Scenario-503: ECS Jenkins Deployment III
- Objective: Deploy Jenkins 1 Master 3 Slaves with 2 nodes in ECS2
- Requirements:
```
1. Start ECS with 2 node
2. Start Jenkins service within ECS. 1 Master and 3 Slaves
3. Enable ALB for Jenkins master
```
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-503.yml)
- See more: [Scenario-503](./Scenario-503)
- TODO
- TODO: How to avoid Jenkins SPOF, theoretically speaking?

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/aws-jenkins-study/master/images/jenkins_ecs_2nodes_4instances.png"/> </a>

## Scenario-601: Large Scale Jenkins Deployment I
- Objective: Suppose you have 1K developers to use your Jenkins. Improve scalability, availability, security, etc.
- Requirements:
```
1. Scalability: multiple Jenkins master instances
2. Availability: Jenkins slave; Jenkins Master
2. Security: VPC, Jenkins authentication integration
```
- Main Tech: Cloudformation, ECS, EBS, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-601.yml)
- See more: [Scenario-601](./Scenario-601)
- TODO

<a href="https://www.dennyzhang.com"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/magic.gif"></a>
# Highlights
- **Principles**:
```
1. Fully automated
2. Improve HA
```

- Really like container deployments over VM deployments.
- Jenkins community don't have HA solution for Jenkins master yet.

- TODO: speed up the whole setup process
- TODO: reduce the deployment failure rate

- More Resources:
```
https://github.com/awslabs/startup-kit-templates
https://github.com/awslabs
```

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!
- Critical Info
```
CentOS Jenkins conf: /etc/sysconfig/jenkins
```

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
