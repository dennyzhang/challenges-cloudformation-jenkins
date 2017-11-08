# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: default
#
# Copyright 2015, TOTVS Labs
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'os-basic::default'

if node['jenkins_mdm']['install_devkit'] == '1'
  include_recipe 'os-basic::devkit'
end

include_recipe 'os-basic::conf_ssh'

include_recipe 'jenkins-demo::conf_jenkins'
include_recipe 'jenkins-demo::setup_repo_server'

service 'jenkins' do
  supports status: true
  action [:enable, :start]
end
