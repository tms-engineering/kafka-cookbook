#
# Cookbook Name:: kafka
# Recipe:: default
#

include_recipe 'kafka::environment'
include_recipe 'kafka::install'
include_recipe 'kafka::configure'
include_recipe 'kafka::upstart'
