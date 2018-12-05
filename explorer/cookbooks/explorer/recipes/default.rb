
execute "apt-get-update" do
  command "apt-get update"
end

package 'sqlite3' do
  action :install
end

package 'libsqlite3-dev' do
  action :install
end

package 'python-dev' do
  action :install
end

package 'python-pip' do
  action :install
end

bash 'upgarde pip' do
  code <<-EOH
  sudo pip install --upgrade pip
	sudo pip install pycrypto
EOH
  
end

package 'unzip' do
  action :install
  only_if { File.exist?('/usr/bin/unzip') == false }
end

directory node['install']['directory'] do
  action :create
  recursive true
  only_if { File.exist?("#{node['install']['directory']}") == false }
end

cookbook_file "#{node['install']['directory']}/#{node['software']['explorer']}" do
  source "#{node['software']['explorer']}"
  owner "root"
  group "root"
  mode 0755
  action :create_if_missing
end

bash 'unzip_explorer' do
  user "root"
  code <<-EOH
  unzip -d #{node['install']['directory']}/. #{node['install']['directory']}/#{node['software']['explorer']}
  mv #{node["install"]["directory"]}/#{node["explorer"]["directory"]}-master #{node["install"]["directory"]}/#{node["explorer"]["directory"]}
  rm -Rf #{node['install']['directory']}/#{node['software']['explorer']}
  EOH
  only_if { File.exist?("#{node['install']['directory']}/#{node['explorer']['directory']}") == false }
end

template "#{node["install"]["directory"]}/#{node["explorer"]["directory"]}/#{node['blockchain']['name']}.conf" do
  source "chain.conf.erb"
  mode "644"

  variables(
      :chain_name => node['blockchain']['name']
  )
end

template "#{node['install']['directory']}/#{node['explorer']['directory']}/#{node['software']['instructions']}" do
  source "instructions.erb"
  mode 0444
  variables(
      :chain_name => node['blockchain']['name']
  )
end


execute "update rpcport" do
  command "echo \"rpcport=2678\" >> /apps/datadir/#{node['blockchain']['name']}/multichain.conf"
end








