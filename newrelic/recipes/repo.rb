#
# Cookbook Name:: newrelic
# Recipe:: repo
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
case node[:platform]
when "centos","redhat","fedora","suse"
  execute "Add Newrelic repo" do
    command  <<-EOF
      rpm -Uvh http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm
      yum clean all
    EOF
  end
when "debian","ubuntu"
  execute "Newrelic key-install" do
    command <<-EOF
      curl -L http://download.newrelic.com/debian/newrelic.list -o /etc/apt/sources.list.d/newrelic.list
      curl -L http://download.newrelic.com/548C16BF.gpg | apt-key add -
      apt-get update
    EOF
  end
end
