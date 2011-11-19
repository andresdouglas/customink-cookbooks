maintainer       "CustomInk, LLC"
maintainer_email "nharvey@customink.com"
license          "Apache 2.0"
description      "Installs/Configures newrelic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "default", "Sets up the New Relic repository, installs, and configures the New Relic Server Monitor"
recipe "repo", "Sets up the New Relic repository"
recipe "sysmond", "Installs and configures the New Relic Server Monitor"
recipe "monit", "Adds a monit control file for watching after the New Relic Server Monitor"

attribute "newrelic/license_key",
  :display_name => "New Relic License Key",
  :description => "New Relic License Key",
  :default => "YOUR_NEWRELIC_LICENSE_KEY"
  
attribute "newrelic/monit/max_memory",
  :display_name => "New Relic Server Monitor Maximum Memory",
  :description => "The maximum amount of memory (MB) that monit will allow before restarting the the newrelic-sysmond",
  :default => "32"

attribute "newrelic/monit/max_cpu",
  :display_name => "New Relic Server Monitor Maximum CPU",
  :description => "The maximum CPU percentage that monit will allow before restarting the the newrelic-sysmond",
  :default => "20"
