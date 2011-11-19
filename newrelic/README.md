Description
===========

Installs [New Relic Server Monitoring](http://newrelic.com/features/server-monitoring) and sets it up as a service running on the node.   There is also a monit cookbook to create a monit control file to watch after the service.

Requirements
============

* You will need to register with [New Relic](http://newrelic.com/) and obtain a License Key

Attributes
==========

* `node[:newrelic][:license_key]` - Your Newrelic License Key
* `node[:newrelic][:monit][:max_memory]` - The maximum amount of memory (MB) that monit will allow before restarting the service.
* `node[:newrelic][:monit][:max_cpu]` - The maximum CPU percentage that monit will allow before restarting the service.

Usage
=====

Include the newrelic recipe to enable New Relic Server Monitoring

    include_recipe "newrelic"

Or add it to your role, or directly to a node's recipes.


Include the monit recipe to add a monit control file to your system.

    include_recipe "mms-agent::monit"

Or add it to your role, or directly to a node's recipes.

