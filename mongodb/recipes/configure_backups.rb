#
# Cookbook Name:: mongodb
# Recipe:: configure_backups
#
# Copyright 2010, CustomInk, LLC
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

# Add in the backup script
mongods = node[:mongodb][:mongods]
mongods.uniq.compact.each do |instance|
  mongod          = instance["mongod"]
  port            = instance["port"]
  run_backups     = instance["run_backups"]
  backup_dir      = "#{node[:mongodb][:backup_dir]}/#{mongod}"

  template "#{node[:mongodb][:binaries]}/mongo_hourly_backup_#{mongod}" do
    source "mongo_hourly_backup.erb"
    variables(
      :port            => port,
      :backup_dir      => backup_dir
    )
    owner node[:mongodb][:user]
    group node[:mongodb][:group]
    mode 0775
  end

  # link in so that the script gets run hourly
  if ((run_backups == true || run_backups == "true") && 
      (node[:mongodb][:run_backups] == true || node[:mongodb][:run_backups] == "true"))
    link "/etc/cron.hourly/mongo_hourly_backup_#{mongod}" do
      to "#{node[:mongodb][:binaries]}/mongo_hourly_backup_#{mongod}"
    end
  end
end
