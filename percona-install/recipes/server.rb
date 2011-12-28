# Cookbook Name:: percona-install
# Recipe:: server
#
# Copyright 2011, CustomInk, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_recipe "percona-install"

case node[:platform]
when "redhat","centos","fedora","suse"
  execute "remove conflicting mysql-libs" do
    command "rpm -e --nodeps mysql-libs "
  end
  
  %w(Percona-Server-server-55 Percona-Server-devel-55 Percona-Server-shared-compat).each do |p|
    package p
  end
when "debian","ubuntu"
  execute "update apt" do
    command "apt-get update"
  end

  package "percona-server-server-5.5"
  package "libmysqlclient-dev"
end