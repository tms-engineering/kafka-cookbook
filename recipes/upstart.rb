#
# Cookbook Name:: kafka
# Recipe:: upstart
#

status_script_path = "#{node[:kafka][:script_dir]}/kafka-status"

template status_script_path do
  source "kafka-status"
  owner node[:kafka][:user]
  group node[:kafka][:group]
  mode "755"
  variables(
    hostname: node[:kafka][:hostname],
    port:     node[:kafka][:port]
  )
end

template "/etc/init/kafka.conf" do
  source "kafka.upstart.conf.erb"
  owner "root"
  group "root"
  mode "644"

  # restart doesn't reload upstart conf, so we stop and start again:
  notifies :stop, "service[kafka]"
  notifies :start, "service[kafka]"

  variables(
    user:           node[:kafka][:user],
    kafka_dir:      node[:kafka][:install_dir],
    log_dir:        node[:kafka][:log_dir],
    jmx_port:       node[:kafka][:jmx_port],
    config:         node[:kafka][:config],
    status_script:  status_script_path
  )
end

service "kafka" do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :status => true, :restart => true
  action :start
end
