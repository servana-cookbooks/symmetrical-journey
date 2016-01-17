
#app = node.run_state[:current_app]

group "#{node['goapp']['group']}" do
  action :create
  append true
end

user "#{node['goapp']['user']}" do
  gid "#{node['goapp']['group']}"
  comment 'goapp user'
  system true
  home "#{node['goapp']['path']}"
  shell '/bin/sh'
end

# we could use variables in node scope but we don't have to
template "/etc/init.d/goapp" do
  source "initscript.erb"
  mode '0755'
  owner "#{node['goapp']['user']}"
  group "#{node['goapp']['group']}"
  variables( :app => 'goapp', :path => "#{node['goapp']['path']}", :shareddir => "#{node['goapp']['shareddir']}", :workdir => "#{node['goapp']['workdir']}", :user => "#{node['goapp']['user']}" )
end

directory node['goapp']['path'] do
  owner "#{node['goapp']['user']}"
  group "#{node['goapp']['group']}"
  mode '0755'
  recursive true
end

deploy_revision "#{node['goapp']['path']}" do
  revision "#{node['goapp']['revision']}"
  repository "#{node['goapp']['repo']}"
  user "#{node['goapp']['user']}"
  group "#{node['goapp']['group']}"
  action :deploy
  shallow_clone true
  migrate false
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks.clear
end

service "goapp" do
  action :start
end

