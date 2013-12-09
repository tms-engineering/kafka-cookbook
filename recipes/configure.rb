#
# Cookbook Name:: kafka
# Recipe:: configure
#

user = node[:kafka][:user]
group = node[:kafka][:group]

config_dir = "#{node[:kafka][:install_dir]}/config"
log_dir = node[:kafka][:log_dir]
data_dir = node[:kafka][:data_dir]

directory config_dir do
  not_if { File.directory?(config_dir) }

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

directory log_dir do
  not_if { File.directory?(log_dir) }

  owner   user
  group   group
  mode    '755'
  recursive true
  action :create
end

directory data_dir do
  not_if { File.directory?(data_dir) }

  owner   user
  group   group
  mode    '755'
  recursive true
  action :create
end
