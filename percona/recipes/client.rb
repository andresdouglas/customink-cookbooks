#
# Cookbook Name:: percona
# Recipe:: client
#
# Copyright 2010, CustomInk, LLC
#
# All rights reserved - Do Not Redistribute
#
require_recipe "percona"

case node[:platform]
when "redhat","centos","fedora","suse"
  package "Percona-Server-client-55"
  package "Percona-Server-devel-55"
when "debian","ubuntu"
  package "percona-server-client-5.5"
  package "libmysqlclient-dev"
end