#
# Cookbook Name:: kafka
# Recipe:: _test_zookeeper
#

include_recipe 'java'

# This fix to ZK (for CentOS 6.3) should go upstream in zookeeper:
include_recipe 'build-essential'
yum_package 'patch' do
  action :install
end.run_action(:install) # ZK does this, so we have to too.

include_recipe "zookeeper::default"
