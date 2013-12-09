#
# Cookbook Name:: kafka
# Recipe:: environment
#

user = node[:kafka][:user]
group = node[:kafka][:group]

group(group)

user(user) do
  gid group
  home "/home/#{user}"
  shell '/bin/false'
  supports(manage_home: false)
end
