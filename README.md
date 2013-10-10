# Description

[![Build Status](https://travis-ci.org/tms-engineering/kafka-cookbook.png?branch=master)](https://travis-ci.org/tms-engineering/kafka-cookbook)

Installs a recent version of Kafka 0.8.0-beta1, which is currently under
development.

Based on the Kafka cookbook initially released by WebTrends and then modified
by Mathias Söderberg (thanks!), but with a few notable differences:

* uses upstart to run the service
* supports only building from source
* does not depend on runit cookbook
* uses the ZK cookbook in development instead of the ZK bundled with Kafka for
  simplicity's sake
* only tested with a CentOS 6.3 Vagrant box

# Requirements

* java ~> 1.11.6
* zookeeper ~> 1.4.6

We would like to remove the zookeeper dependency (and use it only during
testing via `Berksfile`), but doing so results in the zookeeper cookbook's
attributes not getting pulled in correctly at the moment.

# Attributes

* ``node[:kafka][:version]`` - The Kafka version install and use.
* ``node[:kafka][:base_url]`` - URL for Kafka releases.
* ``node[:kafka][:checksum]`` - MD5 checksum for release to use.
* ``node[:kafka][:scala_version]`` - Scala version for Kafka.
* ``node[:kafka][:install_dir]`` - Location for Kafka to be installed.
* ``node[:kafka][:log_dir]`` - Location for Kafka log4j logs.
* ``node[:kafka][:user]`` - User to use for directories and to run Kafka.
* ``node[:kafka][:group]`` - Group for user defined in bullet point above.
* ``node[:kafka][:script_dir]`` - Location where the service status-checking script is installed.
* ``node[:kafka][:log_level]`` - Log level for Kafka logs (and ZooKeeper, for further
  information see below).
* ``node[:kafka][:log4j_config]`` - Name of log4j configuration file (should
  include extension as well). Will use 'log4j.properties' by default.
* ``node[:kafka][:config]`` - Name of configuration file for Kafka (should
  include extension as well). Will use 'server.properties' by default.
* ``node[:kafka][:jmx_port]`` - JMX port for Kafka.

* ``node[:kafka][:broker_id]`` - The id of the broker. This must be set to a unique integer
  for each broker. If not set, it will default to using the machine's ip address
  (without the dots).
* ``node[:kafka][:host_name]`` - Host name the broker will advertise. If not set, Kafka will
  use the host name returned from
``java.net.InetAddress.getCanonicalHostName()``, which might not be what you want.
* ``node[:kafka][:port]`` - The port Kafka will listen on for incoming requests.
* ``node[:kafka][:network_threads]`` - The number of threads handling network requests.
* ``node[:kafka][:io_threads]`` - The number of threads doing disk I/O.
* ``node[:kafka][:num_partitions]`` - The number of logical partitions per topic per server.
  More partitions allow greater parallelism for consumption, but also mean more
  files.

* ``node[:kafka][:socket][:send_buffer_bytes]`` - The send buffer (``SO_SNDBUF``) used by the
  socket server.
* ``node[:kafka][:socket][:receive_buffer_bytes]`` - The receive buffer (``SO_RCVBUF``) used by
  the socket server.
* ``node[:kafka][:socket][:request_max_bytes]`` - The maximum size of a request that the
  socket server will accept (protection against out of memory).

* ``node[:kafka][:log][:dirs]`` - The directory under which Kafka will store log files.
* ``node[:kafka][:log][:flush_interval_messages]`` - The number of messages to accept before
  forcing a flush of data to disk.
* ``node[:kafka][:log][:flush_interval_ms]`` - The maximum amount of time a message can sit
  in a log before Kafka forces a flush to disk.
* ``node[:kafka][:log][:retention_hours]`` - The minimum age of a log file to be eligible for
  deletetion.
* ``node[:kafka][:log][:retention_bytes]`` - A size-based retention policy for logs. Segments
  are pruned from the log as long as the remaining segments don't drop below
  ``log_retention_bytes``.
* ``node[:kafka][:log][:segment_bytes]`` - The maximum size of a log segment file. When this
  size is reached a new log segment will be created.
* ``node[:kafka][:log][:cleanup_interval_mins]`` - The interval at which log segments are
  checked to see if they can be deleted according to the retention policies.

* ``node[:kafka][:zookeeper][:connect]`` - A list of zookeeper nodes to connect to.
* ``node[:kafka][:zookeeper][:timeout]`` - Timeout in milliseconds for connecting to ZooKeeper.

* ``node[:kafka][:metrics][:polling_interval]`` - Polling interval for metrics.
* ``node[:kafka][:metrics][:reporters]`` - Metric reporters to be used.

* ``node[:kafka][:csv_metrics][:dir]`` - Directory path for saving metrics.
* ``node[:kafka][:csv_metrics][:reporter_enabled]`` - Enable/disable CSV metrics reporter.

# Recipes

* environment: creates the user, group, log directory, and data directory for Kafka
* install: fetches, builds, and installs Kafka 0.8 from source
* configure: copies log4j and kafka configuration from templates into the installation
* upstart: creates an upstart service for Kafka

* default: performs all of the above

# Known bugs & limitations

* We would like to remove the zookeeper cookbook dependency outside of development
* No support for Ubuntu/Debian.
* Not tested with other RHEL distributions (Fedora/Amazon/etc).
* No support for per-topic overrides for ``node[:kafka][:log][:flush_interval_ms]``.
* Not sure if all configuration parameters for Kafka are supported at this time.

# License

Copyright :: 2013 Mathias Söderberg, Brian Schroeder

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Check that your change works, for example with Vagrant
5. Submit a Pull Request using Github
