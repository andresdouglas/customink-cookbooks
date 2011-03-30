#
# Cookbook Name:: mongodb
# Recipe:: configure_backups
#
# Copyright 2010, CustomInk, LLC
#

# Add in the backup script
mongods = node[:mongodb][:mongods]
mongods.uniq.compact.each do |instance|
  mongod          = instance["mongod"]
  port            = instance["port"]
  run_backups     = instance["run_backups"]
  backup_dir      = "#{node[:mongodb][:backup_dir]}/#{mongod}"

  template "#{node[:mongodb][:binaries]}/mongo_hourly_backup_#{mongod}.sh" do
    source "mongo_hourly_backup.sh.erb"
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
    link "/etc/cron.hourly/mongo_hourly_backup_#{mongod}.sh" do
      to "#{node[:mongodb][:binaries]}/mongo_hourly_backup_#{mongod}.sh"
    end
  end
end
