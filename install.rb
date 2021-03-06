require 'mixlib/install'

options = {
  channel: ENV['CHEF_CHANNEL'].to_sym,
  product_name: 'chef-server',
  product_version: :latest,
  platform: 'ubuntu',
  platform_version: '14.04',
  architecture: 'x86_64'
}

artifact = Mixlib::Install.new(options).artifact_info

remote_file '/tmp/chef-server.deb' do
  source artifact.url
end

dpkg_package 'chef-server' do
  source '/tmp/chef-server.deb'
  action :install
end

# rm is much faster than file action delete
execute 'rm /tmp/chef-server.deb'

options_manage = {
  channel: ENV['CHEF_CHANNEL'].to_sym,
  product_name: 'manage',
  product_version: :latest,
  platform: 'ubuntu',
  platform_version: '14.04',
  architecture: 'x86_64'
}

artifact_manage = Mixlib::Install.new(options_manage).artifact_info

remote_file '/tmp/chef-manage.deb' do
  source artifact_manage.url
end

dpkg_package 'chef-manage' do
  source '/tmp/chef-manage.deb'
  action :install
end

# rm is much faster than file action delete
execute 'rm /tmp/chef-manage.deb'
