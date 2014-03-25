require 'digest/sha1'

database = node[:hostname]
username = node[:hostname]

template "/srv/#{node[:fqdn]}/shared/database.yml" do
  source "database.yml.erb"
  owner "rvmuser"
  group "rvmuser"
  mode 0644
  variables({
    :environment => 'production',
    :adapter => 'postgresql',
    :database => database,
    :username => username,
    :host => 'postgres'
  })

  not_if "test -e /srv/#{node[:fqdn]}/shared/database.yml"
end

secret = Digest::SHA512.hexdigest(node[:fqdn])
template "/srv/#{node[:fqdn]}/shared/settings.yml" do
  source "settings.yml.erb"
  owner "rvmuser"
  group "rvmuser"
  mode 0644
  variables(:secret => secret)

  not_if "test -e /srv/#{node[:fqdn]}/shared/settings.yml"
end
