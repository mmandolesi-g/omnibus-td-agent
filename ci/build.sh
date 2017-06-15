#!/bin/bash

set -e -u -x

mkdir -p /opt/td-agent /var/cache/omnibus
yum install which git rpm-build -y
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
export PATH="/usr/local/rvm/bin:/usr/local/rvm/rubies/ruby-2.4.0/bin:${PATH}"
gem install bundle
bundle install --binstubs
bin/gem_downloader core_gems.rb
bin/gem_downloader plugin_gems.rb
bin/gem_downloader ui_gems.rb
bin/omnibus build td-agent2
ls -hal pkg/