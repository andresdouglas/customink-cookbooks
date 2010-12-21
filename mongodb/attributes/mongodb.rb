set_unless[:mongodb][:user] = "mongodb"
set_unless[:mongodb][:group] = "mongodb"

set_unless[:mongodb][:bind_address] = "127.0.0.1"
set_unless[:mongodb][:port] = "27017"

set_unless[:mongodb][:version] = '1.6.3'
set_unless[:mongodb][:file_name] = "mongodb-linux-#{kernel[:machine] || 'i686'}-#{mongodb[:version]}"
set_unless[:mongodb][:url]          = "http://downloads.mongodb.org/linux/#{mongodb[:file_name]}.tgz"

set_unless[:mongodb][:root] = "/usr/local/mongodb"
set_unless[:mongodb][:data_dir] = "/var/lib/mongodb"
set_unless[:mongodb][:backup_dir] = "/var/lib/mongodb_backups"
set_unless[:mongodb][:log_dir] = "/var/log/mongodb"
set_unless[:mongodb][:config_dir] = "/etc/mongodb"
set_unless[:mongodb][:pid_dir] = "/var/run"

set_unless[:mongodb][:run_backups] = false
set_unless[:mongodb][:rest] = false

set_unless[:mongodb][:monit][:enabled] = true
set_unless[:mongodb][:monit][:max_memory] = 1024 #MB
set_unless[:mongodb][:monit][:max_cpu] = 80 #%

set_unless[:mongodb][:mongods] = [{"mongod" => "master", "port" => "27017", "replication_set" => "vagrant", "run_backups" => "false"},{"mongod" => "slave", "port" => "27030", "replication_set" => "vagrant", "run_backups" => "true"}]

# Typical mongod ports:
# * Standalone mongod : 27017
# * mongos : 27017
# * shard server (mongod --shardsvr) : 27018
# * config server (mongod --configsvr) : 27019
# * web stats page for mongod : add 1000 to port number (28017, by default)
