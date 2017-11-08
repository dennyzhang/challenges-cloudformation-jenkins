# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: setup_repo_server
#
# Copyright 2015, TOTVS Labs
#
# All rights reserved - Do Not Redistribute
#

#######################################################
# https://supermarket.chef.io/cookbooks/apache2
node.default['apache']['mpm'] = 'prefork'
node.default['apache']['listen'] = ['*:18000']
node.default['apache']['default_site_port'] = '18000'
include_recipe 'apache2'

directory '/var/www/repo' do
  owner 'root'
  group 'root'
  mode 0o777
  action :create
end

web_app 'repo_server' do
  template 'repo_server.conf.erb'
end

cookbook_file '/var/www/repo/README.txt' do
  source 'README.txt'
  mode 0o644
  owner 'root'
end
