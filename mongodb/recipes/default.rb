#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2010, CustomInk, LLC
#
# All rights reserved - Do Not Redistribute
#

mongods = node.mongodb.mongods

this_mongod = "default"

# Ensure there is only one mongo with ths name
mongods.each do |mongo|
  if mongo["mongod"] == this_mongod
    node.mongodb.mongods.delete(mongo)
  end
end

node.mongodb.mongods.push({ 
  "mongod"          => this_mongod, 
  "port"            => "27017", 
  "replication_set" => "default", 
  "run_backups"     => "false", 
  "rest"            => "false", 
  "monit"           => "false"})

