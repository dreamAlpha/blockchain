

directory "#{node['app']['directory']}" do
  action :create
  recursive true
end


cookbook_file "#{node['app']['directory']}/#{node['software']['multichain']}" do
  source "#{node['software']['multichain']}"
  action :create_if_missing
  not_if { ::File.exists?("#{node['app']['directory']}/#{node['software']['multichain']}")}
end

powershell_script 'extract_file' do
  code <<-EOH
  [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
  [System.IO.Compression.ZipFile]::ExtractToDirectory('#{node['app']['directory']}/#{node['software']['multichain']}', '#{node['app']['directory']}')
  EOH
  not_if { ::File.exists?("#{node['app']['directory']}/#{node['data']['directory']}")}
end

powershell_script 'delete_zipfile' do
  code <<-EOH
  del #{node['app']['directory']}/#{node['software']['multichain']}
  EOH
end

directory "#{node['app']['directory']}/#{node['data']['directory']}" do
  action :create
  recursive true
end

powershell_script 'extract_file' do
  code <<-EOH
    SETX PATH "%PATH%;#{node['app']['directory']}"
  EOH
end

