powershell_script 'create_chain' do
  code <<-EOH
    multichain-util create -datadir=#{node['app']['directory']}#{node['data']['directory']} #{node['blockchain']['name']}
  EOH
end

#this can be replaced using command line parameters
template "#{node['app']['directory']}#{node['data']['directory']}/#{node["blockchain"]["name"]}/params.dat" do

  source "params.dat.erb"
  variables(
      :chain_name => node['blockchain']['name']
  )
  action :create_if_missing
end


powershell_script 'initiate_new_chain' do
code <<-EOH
    multichaind -datadir=#{node['app']['directory']}#{node['data']['directory']} #{node["blockchain"]["name"]} -daemon > #{node['app']['directory']}#{node['data']['directory']}/logs.txt
EOH
end

#rpc connection to the chain - interactive mode will work in linux
#multichain-cli <blockchainname> -datadir=c:/apps/datadir/  getinfo