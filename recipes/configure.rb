#
# Cookbook Name:: kafka
# Recipe:: configure
#

config_dir = "#{node[:kafka][:install_dir]}/config"
user = node[:kafka][:user]
group = node[:kafka][:group]

directory config_dir do
  owner user
  group group
  mode '755'
  recursive true
  action :create
end

template "#{config_dir}/#{node[:kafka][:log4j_config]}" do
  source  "log4j.properties.erb"
  owner user
  group group
  mode  '644'
  variables({
    :process => 'kafka',
    :log_dir => node[:kafka][:log_dir]
  })
end

template "#{config_dir}/#{node[:kafka][:config]}" do
  source  "server.properties.erb"
  owner user
  group group
  mode  '644'
end
