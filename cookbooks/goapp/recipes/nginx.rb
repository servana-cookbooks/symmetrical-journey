
template "/etc/nginx/sites-available/001-goapp" do
	source "nginx_goapp_conf.erb"
  mode '0644'
  owner "#{node['nginx']['user']}"
  group "#{node['nginx']['group']}"
  variables( :backend_servers => node['nginx']['backend_servers'], :server_name => node['nginx']['server_name'], :port => node['nginx']['port'])
end

nginx_site "001-goapp" do 
	enable true
end

nginx_site "000-default" do
  enable false
end

service "nginx" do
  action :restart
end