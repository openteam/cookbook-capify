script "Install nginx" do
  interpreter "bash"
  user "root"
  code <<-EOH
  aptitude update
  aptitude install debian-keyring
  gpg --keyserver pgp.mit.edu --recv-keys ABF5BD827BD9BF62 && gpg --armor --export ABF5BD827BD9BF62 | apt-key add -
  gpg --keyserver pgp.mit.edu --recv-keys 07DC563D1F41B907 && gpg --armor --export 07DC563D1F41B907 | apt-key add -
  apt-get --yes --force-yes install nginx
  mkdir -p /etc/nginx/vhosts/
  EOH
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/etc/nginx/vhosts/#{node[:fqdn]}.conf" do
  source "default-site.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

script "Reload nginx with new config files" do
  interpreter "bash"
  user "root"
  code <<-EOH
  /etc/init.d/nginx reload
  EOH
end

