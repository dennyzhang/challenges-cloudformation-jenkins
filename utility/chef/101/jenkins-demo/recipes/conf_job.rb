# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: conf_job
#
# Copyright 2017, DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

node['jenkins_demo']['jenkins_jobs'].split(',').each do |job_name|
  config = File.join(Chef::Config[:file_cache_path], "#{job_name}.xml")

  template config do
    source "#{job_name}.xml.erb"
  end

  # Create a jenkins job (default action is `:create`)
  jenkins_job job_name do
    config config
  end
end
