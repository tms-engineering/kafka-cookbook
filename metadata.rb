# encoding: utf-8

name             'kafka'
maintainer       'Brian Schroeder'
maintainer_email 'bschroeder@tribune.com'
license          'Apache 2.0'
description      'Installs and runs Kafka 0.8 on CentOS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'java', '~> 1.11.6'
# ZK is only needed for development, but its attributes aren't pulled in
# correctly if this isn't listed here:
depends 'zookeeper', '~> 1.4.6'

%w[centos].each do |os|
  supports os
end
