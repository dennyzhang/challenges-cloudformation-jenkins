# -*- encoding: utf-8 -*-

require 'serverspec'

# Required by serverspec
set :backend, :exec

require_relative '/opt/common_library'
print_local_ip
#############################################################################
# TODO: make the code more general
require 'json'
chef_data = JSON.parse(IO.read('/tmp/kitchen/dna.json'))
app_branch_name = chef_data.fetch('common_basic').fetch('app_branch_name')
framework_branch_name = chef_data.fetch('common_basic').fetch('framework_branch_name')
devops_branch_name = chef_data.fetch('common_basic').fetch('devops_branch_name')

describe command('java -version') do
  its(:stderr) { should contain 'java version \"1.8' }
end

node_version = 'v6.11.2'
describe command('/usr/local/bin/node --version') do
  its(:stdout) { should contain node_version }
end

npm_version = '3.10.10'
describe command('/usr/local/bin/npm --version') do
  its(:stdout) { should contain npm_version }
end

wait_for('30', 'lsof -i tcp:18080')

%w(18000 18080).each do |port|
  describe port(port) do
    it { should be_listening }
  end
end

jenkins_run_cmd = 'java -jar /root/jenkins-cli.jar -s http://localhost:18080/ build '
jenkins_check_cmd = 'bash -xe /root/poll_jenkins_job.sh ' \
                    '/root/jenkins-cli.jar http://127.0.0.1:18080 '

wait_jenkins_up('')
#############################################################################
# Inject github deploy key
git_deploykey = '/var/lib/jenkins/.ssh/github_id_rsa'
describe command("cp /tmp/kitchen/data/mdm_deploy_key #{git_deploykey}") do
  its(:exit_status) { should eq 0 }
end

describe command("chown jenkins:jenkins #{git_deploykey}") do
  its(:exit_status) { should eq 0 }
end

describe command("chmod 400 #{git_deploykey}") do
  its(:exit_status) { should eq 0 }
end

# Update JenkinsItself to deploy the ssh key properly
parameters = " -p devops_branch_name=#{devops_branch_name} "
job_name = 'UpdateJenkinsItself'
run_jenkins_job(jenkins_run_cmd, job_name, parameters)
run_check_jenkins_job(jenkins_run_cmd, jenkins_check_cmd, job_name, parameters)

# Build code
parameters = '-p force_build=true -p clean_start=false' \
            " -p framework_branch_name=#{framework_branch_name}" \
            " -p app_branch_name=#{app_branch_name}"
job_name = 'BuildMDMRepo'
run_jenkins_job_with_retry(jenkins_run_cmd, jenkins_check_cmd, job_name, parameters)
