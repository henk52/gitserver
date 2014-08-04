henk52-gitserver
===============


Puppet module for a git server.


LIMITATIONS:
- Right now it has only been tested on Fedora (20).


Installation:
# cd /etc/puppet/modules
# git clone https://github.com/henk52/gitserver.git


Default installation of git-server
  sudo puppet apply --verbose /etc/puppet/modules/gitserver/manifests/install.pp

# Usage:

## Creating a repository

1. ssh -l git GITSERVER
2. newgit alpha


## Cloning a repository with write access

* git clone ssh://git@GITSERVER/var/git/alpha.git


## Cloning a repository with read-only access

* git clone http://GITSERVER/git/alpha.git
