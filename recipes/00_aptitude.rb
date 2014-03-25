template "/etc/apt/sources.list" do
  source "sources.list.erb"
  owner "root"
  group "root"
  mode 0644
end

script "Update server" do
  interpreter "bash"
  user "root"
  code <<-EOH
  aptitude update
  aptitude safe-upgrade --assume-yes
  EOH
end

