# == Class: gitserver
#
# Full description of class server here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { server:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class gitserver (
  $szGitDirectory = hiera( 'GitDirectory', '/var/git' ),
  $szWebProcessOwnerName = hiera( 'WebProcessOwner', 'lighttpd' )
) {

$szModulePath = "/etc/puppet"

# This manifest configure a git server.

# see also: http://git-scm.com/book/ch4-4.html

# This ought to go into a common repository, somehow.
package { 'git':
  ensure => installed,
}

package { 'lighttpd':
  ensure => installed,
}


user { 'git':
  ensure     => present,
  home       => '/home/git',
  managehome => true,
  shell      => '/usr/bin/git-shell',
  require    => Package [ 'git' ],
}


file { '/home/git/git-shell-commands':
  ensure  => directory,
  owner   => 'git',
  group   => 'git',
}

file { '/home/git/git-shell-commands/help':
  ensure  => file,
  owner   => 'git',
  group   => 'git',
  mode    => '555',
  source  => "$szModulePath/modules/gitserver/files/help",
  #source  => 'modules/gitserver/help',
  #source  => 'puppet:///modules/gitserver/help',
  #source  => 'puppet:///modules/gitserver/files/help',
  require  => File [ '/home/git/git-shell-commands' ],
}

file { '/home/git/git-shell-commands/list':
  ensure  => file,
  owner   => 'git',
  group   => 'git',
  mode    => '555',
  source  => "$szModulePath/modules/gitserver/files/list",
  require  => File [ '/home/git/git-shell-commands' ],
}

file { '/home/git/git-shell-commands/newgit':
  ensure   => file,
  owner    => 'git',
  group    => 'git',
  mode     => '555',
  source   => "$szModulePath/modules/gitserver/files/newgit",
  require  => File [ '/home/git/git-shell-commands' ],
}


file { '/home/git/.ssh':
  ensure   => directory,
  owner    => 'git',
  group    => 'git',
  mode     => '700',
}

file { '/home/git/.ssh/authorized_keys':
  ensure   => file,
  owner    => 'git',
  group    => 'git',
  mode     => '700',
  require  => File [ '/home/git/.ssh' ],
}

# The directory where the repositories are to be stored.
# Make the parent path, configuratble, for later when the projects are larger.
file { "$szGitDirectory":
  ensure  => directory,
  owner   => git,
  group   => "$szWebProcessOwnerName",
  require => [ 
               User[ 'git' ],
               Package [ 'lighttpd' ],
             ],
}


#file_line { 'add_git_share':
#  line    => "alias.url += ( \"/git/\" => \"/var/git/\" )",
#  path    => '/etc/lighttpd/lighttpd.conf',
#  require => [
#               File [ '/etc/lighttpd/lighttpd.conf' ],
#               User [ 'git' ],
#               Package [ 'lighttpd' ],
#             ],
#  notify  => Service [ 'lighttpd' ],
#}


}
