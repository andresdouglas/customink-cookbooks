Description
===========

This cookbook installs the percona-release rpm.

When you install the Percona RPM, it configures YUM to use the Percona repository, plus installs the key used for signing RPMs.

More info:  http://www.percona.com/docs/wiki/percona-server:release:start


Requirements
============

none

Attributes
==========

none

Usage
=====

Include the recipe to install the percona-release rpm

    include_recipe "percona"

Or add it to your role, or directly to a node's recipes.
