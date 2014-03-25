template "/etc/init.d/unicorn" do
  source "unicorn.sh.erb"
  owner "root"
  group "root"
  mode 0755

  not_if "test -e /etc/init.d/unicorn"
end

