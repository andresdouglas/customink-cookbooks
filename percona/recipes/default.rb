#
# Cookbook Name:: percona
# Recipe:: default
#
# Copyright 2010, CustomInk, LLC
#
# All rights reserved - Do Not Redistribute
#
# http://www.percona.com/docs/wiki/repositories:yum
case node[:platform]
when "redhat","centos","fedora","suse"
  arch = node[:kernel][:machine]
  arch = "i386" unless arch == "x86_64"
  
  rpm_file = "percona-release-0.0-1.#{arch}.rpm"

  remote_file "/var/tmp/#{rpm_file}" do
    source "http://www.percona.com/downloads/percona-release/#{rpm_file}"
    owner  "root"
    mode   0644
  end

  package "percona-release" do
    source "/var/tmp/#{rpm_file}"
    options "--nogpgcheck"
  end

when "debian","ubuntu"
  
  execute "key-install" do
	  command "gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A | gpg -a --export CD2EFD2A | apt-key add -; apt-get update"
	end

	cookbook_file "/etc/apt/sources.list.d/percona_repo.list" do
	  owner "root"
	  group "root"
	  mode "0644"
	  notifies :run, resources(:execute => "key-install"), :immediately
	end
end
