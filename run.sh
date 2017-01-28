#!/bin/bash -xe

#set -x

# For Postgres performance
sysctl -w kernel.shmmax=17179869184

export PATH=/opt/opscode/bin:$PATH

# Start this so that chef-server-ctl sv-related commands can
# interact with its services via runsv
/opt/opscode/embedded/bin/runsvdir-start &

# Start this so that chef-manage-ctl sv-related commands can
# interact with its services via runsv
/opt/chef-manage/embedded/bin/runsvdir-start &

chef-apply setup.rb

# Something useful that also keeps the container running...
tail -f /var/log/opscode/nginx/access.log
