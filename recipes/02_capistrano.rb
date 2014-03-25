%w{releases shared}.each do |dir|
  directory "/srv/#{node[:fqdn]}/#{dir}" do
    owner "rvmuser"
    group "rvmuser"
    mode "0775"
    action :create
    recursive true
   end
end

%w{assets bundle config log pids system database sockets}.each do |dir|
  directory "/srv/#{node[:fqdn]}/shared/#{dir}" do
    owner "rvmuser"
    group "rvmuser"
    mode "0775"
    action :create
    recursive true
   end
end

script "wtf? permitions!" do
  interpreter "bash"
  user "root"
  code <<-EOH
  chown -R rvmuser:rvmuser "/srv/#{node[:fqdn]}/"
  EOH
end
