# -*- encoding: utf-8 -*-

#
# Cookbook Name:: jenkins-demo
# Recipe:: default
#
# Copyright 2017, DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jenkins-demo::master'

if platform_family?('debian')
  # Install iproute2 for ss package
  %w[lsof iproute2].each do |x|
    package x do
      action :install
      not_if "dpkg -l #{x} | grep -E '^ii'"
    end
  end
else
  %w[lsof].each do |x|
    package x do
      action :install
      # TODO: change this
      # not_if "dpkg -l #{x} | grep -E '^ii'"
    end
  end
end
