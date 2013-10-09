# encoding: utf-8

require 'spec_helper'

describe 'kafka::default' do
  let :chef_run do
    ChefSpec::ChefRunner.new(platform: 'centos', version: '6.3').converge(described_recipe)
  end

  it 'includes java::default recipe' do
    expect(chef_run).to include_recipe('java::default')
  end

  it 'creates a kafka group' do
    expect(chef_run).to create_group('kafka')
  end

  it 'creates a kafka user' do
    expect(chef_run).to create_user('kafka')

    user = chef_run.user('kafka')
    expect(user.shell).to eq('/bin/false')
    expect(user.home).to eq('/home/kafka')
    expect(user.gid).to eq('kafka')
  end

  it 'creates a log directory' do
    expect(chef_run).to create_directory('/var/log/kafka')

    directory = chef_run.directory('/var/log/kafka')
    expect(directory).to be_owned_by('kafka', 'kafka')
    expect(directory.mode).to eq('755')
  end

  it 'creates a data directory' do
    expect(chef_run).to create_directory('/var/kafka')

    directory = chef_run.directory('/var/kafka')
    expect(directory).to be_owned_by('kafka', 'kafka')
    expect(directory.mode).to eq('755')
  end

  it 'creates an upstart script' do
    file_path = '/etc/init/kafka.conf'
    expect(chef_run).to create_file(file_path)

    file = chef_run.template(file_path)
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq('644')
  end

  it 'starts a kafka service' do
    service = chef_run.service('kafka')

    expect(service.action).to eq([:start])
  end
end
