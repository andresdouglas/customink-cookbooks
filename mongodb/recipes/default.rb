#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2010, CustomInk, LLC
#
# All rights reserved - Do Not Redistribute
#
begin
    node.mongodb.mongods.push({ 
      "mongod"          => "default", 
      "port"            => "27017", 
      "replication_set" => "default", 
      "run_backups"     => "false", 
      "rest"            => "false", 
      "monit"           => "false"})

rescue Exception => e
  Chef::Log.error("Unable to push the 'default' mongod to this node.")
  Chef::Log.error("#{e.inspect}")
end