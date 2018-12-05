directory "#{node['app']['directory']}#{node['data']['directory']}" do
  owner "root"
  group "root"
  mode 0755
  action :create
  recursive true
end


cookbook_file "#{node['temp']['directory']}/#{node['software']['multichain']}" do
  source "#{node['software']['multichain']}"
  owner "root"
  group "root"
  mode 0755
  action :create_if_missing
end

execute 'extract_tar' do
  command "tar --strip-components=1 -zxf #{node["temp"]["directory"]}/#{node['software']['multichain']} -C #{node['app']['directory']}/."

  not_if { File.exists?("#{node["temp"]["directory"]}#{node['software']['multichain']}") }
end

execute 'clean_up' do
  command "rm -Rf #{node["temp"]["directory"]}/#{node['software']['multichain']}"
end

bash 'add_app_to_path' do
  code <<-EOH
  PATH=$PATH:#{node['app']['directory']}
  export PATH
  EOH
end




 




