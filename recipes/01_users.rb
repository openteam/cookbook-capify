script "Add rvmuser" do
  interpreter "bash"
  user "root"
  code <<-EOH
  aptitude install -y sudo
  groupadd rvmuser
  /usr/sbin/useradd -g rvmuser -m -s /bin/bash rvmuser
  EOH
end

template "/etc/sudoers" do
  source "sudoers.erb"
  owner "root"
  group "root"
  mode 0440
end

