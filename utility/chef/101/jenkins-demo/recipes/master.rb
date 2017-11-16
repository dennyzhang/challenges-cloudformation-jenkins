# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: master
#
# Copyright 2017, DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

apt_update 'update' if platform_family?('debian')

node.default['java']['install_flavor'] = 'oracle'
node.default['java']['jdk_version'] = '8'
node.default['java']['set_etc_environment'] = true
node.default['java']['oracle']['accept_oracle_download_terms'] = true

include_recipe 'java::default'
include_recipe 'jenkins::master'

# Install some plugins needed, but not installed on jenkins2 by default
node['jenkins_plugins'].each do |plugin|
  jenkins_plugin plugin[0] do
    version plugin[1]
    notifies :execute, 'jenkins_command[safe-restart]', :immediately
  end
end

jenkins_command 'safe-restart' do
  action :nothing
end
