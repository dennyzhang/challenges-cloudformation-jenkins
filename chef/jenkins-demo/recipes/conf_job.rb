# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: conf_job
#
# Copyright 2015, TOTVS Labs
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'devops_basic::files'

directory '/root' do
  owner 'root'
  group 'root'
  mode 0o755
  action :create
end

%w(/var/lib/jenkins/code/ /var/lib/jenkins/code/scripts/).each do |x|
  directory x do
    owner 'jenkins'
    group 'jenkins'
    mode 0o755
    action :create
  end
end

cookbook_file '/var/lib/jenkins/code/scripts/deploy_allinone.sh' do
  source 'devops_public/jenkins_scripts/chef/deploy_allinone.sh'
  cookbook 'devops_library'
  mode 0o755
end

cookbook_file '/var/lib/jenkins/code/scripts/collect_files.sh' do
  source 'devops_public/jenkins_scripts/jenkins/collect_files.sh'
  cookbook 'devops_library'
  mode 0o755
end

cookbook_file '/var/lib/jenkins/code/scripts/mdm_build_code.sh' do
  source 'mdm_build_code.sh'
  mode 0o755
end

node['jenkins_mdm']['jenkins_jobs'].split(',').each do |job_name|
  config = File.join(Chef::Config[:file_cache_path], "#{job_name}.xml")

  template config do
    source "#{job_name}.xml.erb"
  end

  # Create a jenkins job (default action is `:create`)
  jenkins_job job_name do
    config config
  end
end
