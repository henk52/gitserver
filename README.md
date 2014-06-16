henk52-gitserver
===============


Puppet module for a git server.


LIMITATIONS:
- Right now it has only been tested on Fedora (20).


Installation:
# cd /etc/puppet/modules
# git clone https://github.com/henk52/gitserver.git


Usage:

Defalt installation of git-server
  sudo puppet apply --verbose /etc/puppet/modules/gitserver/manifests/install.pp

