# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: conf_jenkins
#
# Copyright 2015, TOTVS Labs
#
# All rights reserved - Do Not Redistribute
#
#######################################################
# https://supermarket.chef.io/cookbooks/jenkins#readme
# Install Jenkins

node.default['jenkins']['master']['install_method'] = 'package'
node.default['jenkins']['java'] = '/usr/lib/jvm/java-8-oracle-amd64/bin/java'
node.default['jenkins']['master']['port'] = 18_080
node.default['jenkins']['executor']['timeout'] = 120
node.default['jenkins']['master']['endpoint'] = "http://\
#{node['jenkins']['master']['host']}:#{node['jenkins']['master']['port']}"

# jenkins/recipes/_master_package.rb L28-L32:
#    apt_repository 'jenkins' will always demand internet
if node['jenkins_mdm']['avoid_external_network'] == '0'
  include_recipe 'jenkins::master'
else
  service 'jenkins' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
  end
end

#######################################################
# Grant jenkins user root privilege
file '/etc/sudoers.d/jenkins' do
  mode '0440'
  content '%jenkins ALL=(ALL:ALL) NOPASSWD: ALL'
end

#######################################################
%w(/var/lib/jenkins/.ssh /var/lib/jenkins/.m2).each do |x|
  directory x do
    owner 'jenkins'
    group 'jenkins'
    mode 0o755
    action :create
  end
end

# ssh login key
cookbook_file '/var/lib/jenkins/ssh_id_rsa' do
  source 'sshlogin_id_rsa'
  owner 'jenkins'
  group 'jenkins'
  mode 0o400
end

ssh_config 'github.com' do
  options 'User' => 'git', \
          'IdentityFile' => '/var/lib/jenkins/.ssh/github_id_rsa', \
          'StrictHostKeyChecking' => 'no'
  user 'jenkins'
end

#######################################################

# TODO: enable jenkins plugins with mininum performance downgrade

# https://wiki.jenkins-ci.org/display/JENKINS/Simple+Theme+Plugin
# jenkins_plugin 'simple-theme-plugin' do
#   version '0.3'
# end

# https://wiki.jenkins-ci.org/display/JENKINS/Timestamper
# jenkins_plugin 'timestamper' do
#   version '1.8.4'
# end

# install depended plugins for naginator
jenkins_plugin 'bouncycastle-api' do
  version '2.16.0'
end

jenkins_plugin 'structs' do
  version '1.5'
end

jenkins_plugin 'junit' do
  version '1.18'
end

jenkins_plugin 'script-security' do
  version '1.22'
end

jenkins_plugin 'matrix-project' do
  version '1.7.1'
end

jenkins_plugin 'naginator' do
  version '1.17.2'
  # Note: can't run below, this jenkins job will fail
  # notifies :reload, "service[jenkins]", :delayed
  notifies :run, 'execute[restart jenkins]', :delayed
end

file '/root/restart_jenkins_background.sh' do
  content "#!/bin/bash\nsleep 10\nservice jenkins force-reload"
  mode '0755'
end

execute 'restart jenkins' do
  command 'nohup /root/restart_jenkins_background.sh ' \
          '>> /var/log/jenkins.log 2>&1 &'
  action :nothing
end

# restart jenkins

#######################################################
cookbook_file '/var/lib/jenkins/.m2/settings.xml' do
  source 'm2_settings.xml'
  mode '0644'
  owner 'jenkins'
  group 'jenkins'
end

include_recipe 'jenkins-demo::conf_job'

link '/usr/bin/java' do
  to '/usr/lib/jvm/java-8-oracle-amd64/bin/java'
end
