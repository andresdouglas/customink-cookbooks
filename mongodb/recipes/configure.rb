#
# Cookbook Name:: multi-mongodb
# Recipe:: configure
mongods = node[:mongodb][:mongods]
mongods.uniq.compact.each do |instance|
# mongods.each do |instance|

  mongod          = instance["mongod"]
  port            = instance["port"]
  replication_set = instance["replication_set"]
  
  # get rest setting from the instance, or the node
  rest = instance["rest"]
  if rest.nil? || rest == ""
    rest = node.mongodb.rest
  end
  
  # get monit from the instance, or the node
  monit = instance["monit"]
  if monit.nil? || monit == ""
    monit = node.mongodb.monit.enabled
  end
    
  ["#{node[:mongodb][:log_dir]}/#{mongod}", 
   "#{node[:mongodb][:data_dir]}/#{mongod}",
   "#{node[:mongodb][:backup_dir]}/#{mongod}", 
   "#{node[:mongodb][:pid_dir]}"].each do |dir|
    directory dir do
      owner node[:mongodb][:user]
      group node[:mongodb][:group]
      mode 0755
      recursive true
      action :create
      not_if { File.directory?(dir) }
    end
  end
  
  # create init.d service
  template "/etc/init.d/mongodb_#{mongod}" do
    source "init.sh.erb"
    variables(
      :configuration_file => "#{node[:mongodb][:config_dir]}/mongodb_#{mongod}.conf",
      :mongod => mongod
    )
    owner "root"
    group "root"
    mode 0755
  end
  
  
  service "mongodb_#{mongod}" do
    case node[:platform]
    when "centos","redhat","fedora","suse"
      service_name "mongodb_#{mongod}"
      start_command "/sbin/service mongodb_#{mongod} start"
      stop_command "/sbin/service mongodb_#{mongod} stop"
      restart_command "/sbin/service mongodb_#{mongod} restart && sleep 1"
    when "debian","ubuntu"
      service_name "mongodb_#{mongod}"
      start_command "/etc/init.d/mongodb_#{mongod} start"
      stop_command "/etc/init.d/mongodb_#{mongod} stop"
      restart_command "/etc/init.d/mongodb_#{mongod} restart && sleep 1"
    end
    supports value_for_platform(
      "debian" => { "default" => [ :start, :stop, :restart, :status ] },
      "ubuntu" => { "default" => [ :start, :stop, :restart, :status ] },
      "centos" => { "default" => [ :start, :stop, :restart, :status ] },
      "redhat" => { "default" => [ :start, :stop, :restart, :status ] },
      "fedora" => { "default" => [ :start, :stop, :restart, :status ] },
      "default" => { "default" => [ :start, :stop, :restart, :reload ] }
    )
    # supports :start => true, :stop => true, :restart => true
    action :enable
  end
  
  # create config directory and file
  directory "#{node[:mongodb][:config_dir]}" do
    action :create
    owner "root"
    group "root"
    mode 0755
  end
  
  template "/etc/mongodb/mongodb_#{mongod}.conf" do
    source "mongodb.conf.erb"
    variables(
      :database_path   => "#{node[:mongodb][:data_dir]}/#{mongod}",
      :port            => port,
      :log_path        => "#{node[:mongodb][:log_dir]}/#{mongod}",
      :rest            => rest,
      :replication_set => replication_set
    )
    owner "root"
    group "root"
    mode 0744
    notifies :restart, resources(:service => "mongodb_#{mongod}")
  end
  
  service "mongodb_#{mongod}" do
    action :start
  end
  
  if monit == "true" || monit == true
    # set-up monit
    template "/etc/monit.d/monit_mongo_#{mongod}" do
      source "monit_mongo.erb"
      variables(
        :database_path   => "#{node[:mongodb][:data_dir]}/#{mongod}",
        :mongod          => mongod,
        :port            => port
      )
      owner "root"
      group "root"
      mode 0755
      notifies :restart, resources(:service => "monit")
    end
  end
end
