#
# Cookbook Name:: multi-mongodb
# Recipe:: install
#
# Copyright 2010, CustomInk, LLC
#

group node[:mongodb][:group] do
  action [ :create, :manage ]
end


user node[:mongodb][:user] do
  comment "MongoDB Server"
  gid node[:mongodb][:group]
  # home node[:mongodb][:root]
  action [ :create, :manage ]
end


if !(::File.exists?("/tmp/#{node[:mongodb][:file_name]}.tgz")) && !(::File.directory?(node[:mongodb][:root]))
  Chef::Log.info "Downloading MongoDB (#{node[:mongodb][:file_name]}.tgz) from #{node[:mongodb][:url]}. This could take a while..."
  remote_file "/tmp/#{node[:mongodb][:file_name]}.tgz" do
    source node[:mongodb][:url]
    not_if { ::File.exists?("/tmp/#{node[:mongodb][:file_name]}.tgz") }
  end
end

bash "install-mongodb" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf #{node[:mongodb][:file_name]}.tgz
  mv  #{node[:mongodb][:root]}  #{node[:mongodb][:root]}.bak
  mv #{node[:mongodb][:file_name]} #{node[:mongodb][:root]}
  chmod 755 #{node[:mongodb][:root]}
  EOH
  not_if { ::File.exists?("#{node[:mongodb][:root]}/bin/mongod") }
end

# Add bin directory to everyone's path for bash
template "/etc/profile.d/mongodb.sh" do
  source "mongo.sh.erb"
  owner "root"
  group "root"
  mode 0755
end

# Add bin directory to everyone's path for csh
template "/etc/profile.d/mongodb.csh" do
  source "mongo.csh.erb"
  owner "root"
  group "root"
  mode 0755
end


