#
# Cookbook Name:: kafka
# Recipe:: environment
#

user = node[:kafka][:user]
group = node[:kafka][:group]
log_dir = node[:kafka][:log_dir]
data_dir = node[:kafka][:data_dir]

group(group)

user(user) do
  gid group
  home "/home/#{user}"
  shell '/bin/false'
  supports(manage_home: false)
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
