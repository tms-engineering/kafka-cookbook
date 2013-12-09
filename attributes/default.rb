#
# Cookbook Name:: kafka
# Attributes:: default
#

default[:kafka][:version] = '0.8.0'

default[:kafka][:base_url] = 'http://mirrors.ibiblio.org/apache/kafka'
default[:kafka][:checksum] = '46b3e65e38f1bde4b6251ea131d905f4'

default[:kafka][:scala_version] = '2.9.2'
default[:kafka][:install_dir] = '/opt/kafka'
default[:kafka][:data_dir] = '/var/kafka'
default[:kafka][:log_dir] = '/var/log/kafka'
default[:kafka][:user] = 'kafka'
default[:kafka][:group] = 'kafka'
default[:kafka][:script_dir] = '/usr/local/bin'
default[:kafka][:log_level] = "INFO"
default[:kafka][:log4j_config] = 'log4j.properties'
default[:kafka][:config] = 'server.properties'
default[:kafka][:jmx_port] = 9999

default[:kafka][:broker_id] = node[:ipaddress].gsub('.', '')
default[:kafka][:host_name] = node[:fqdn]
default[:kafka][:port] = 9092
default[:kafka][:network_threads] = 2
default[:kafka][:io_threads] = 2
default[:kafka][:num_partitions] = 1

default[:kafka][:socket][:send_buffer_bytes] = 1048576
default[:kafka][:socket][:receive_buffer_bytes] = 1048576
default[:kafka][:socket][:request_max_bytes] = 104857600

default[:kafka][:log][:flush_interval_messages] = 10000
default[:kafka][:log][:flush_interval_ms] = 1000
default[:kafka][:log][:retention_hours] = 168
default[:kafka][:log][:retention_bytes] = 1073741824
default[:kafka][:log][:segment_bytes] = 536870912
default[:kafka][:log][:cleanup_interval_mins] = 1

default[:kafka][:zookeeper][:connect] = []
default[:kafka][:zookeeper][:timeout] = 1000000

default[:kafka][:metrics][:polling_interval] = 5
default[:kafka][:metrics][:reporters] = ['kafka.metrics.KafkaCSVMetricsReporter']

default[:kafka][:csv_metrics][:dir] = '/tmp/kafka_metrics'
default[:kafka][:csv_metrics][:reporter_enabled] = false
