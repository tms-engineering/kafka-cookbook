#
# Cookbook Name:: kafka
# Recipe:: install
#

include_recipe 'java'

user = node[:kafka][:user]
group = node[:kafka][:group]
scala_version = node[:kafka][:scala_version]
checksum = node[:kafka][:checksum]
kafka_version = node[:kafka][:version]
source_dirname = "kafka-#{kafka_version}-src"
tarball_basename = "#{source_dirname}.tgz"
tarball_url = "#{node[:kafka][:base_url]}/#{tarball_basename}"
cache_dir = Chef::Config[:file_cache_path]
tarball_path = "#{cache_dir}/#{tarball_basename}"
install_dir = node[:kafka][:install_dir]
# TODO: this should probably be somewhere else than in cache_dir:
build_dir = "#{cache_dir}/kafka_build"
release_name = "kafka_#{scala_version}-#{kafka_version}"
release_dir = "#{build_dir}/#{source_dirname}/target/RELEASE/#{release_name}"
installed_jar_path = "#{install_dir}/#{release_name}.jar"

if !(already_installed = File.exists?(installed_jar_path))
  directory(build_dir) do
    owner user
    group group
    mode '755'
    recursive true
    action :create
  end

  remote_file(tarball_path) do
    source tarball_url
    mode '644'
    checksum checksum
  end

  bash "compile kafka" do
    cwd build_dir
    code <<-SHELL
      tar zxvf #{tarball_path}
      cd #{source_dirname}
      ./sbt update
      ./sbt "++#{scala_version} release-zip"
    SHELL
  end

  bash "install kafka" do
    code <<-SHELL
      mv #{release_dir} #{install_dir}
      chown -R #{user}:#{group} #{install_dir}
    SHELL
  end
end
