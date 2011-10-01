#
# Cookbook Name:: percona
# Recipe:: server
#
# Copyright 2010, CustomInk, LLC
#
# All rights reserved - Do Not Redistribute
#
require_recipe "percona::default"
case node[:platform]
when "redhat","centos","fedora","suse"
  package "Percona-Server-server-55"
  package "Percona-Server-devel-55"
when "debian","ubuntu"
  package "percona-server-server-5.5"
  package "libmysqlclient-dev"
end