bash 'create_blockchain' do
  code <<-EOH
    /apps/multichain-util create -datadir=#{node['app']['directory']}#{node['data']['directory']} #{node['blockchain']['name']}
    sudo rm #{node['app']['directory']}#{node['data']['directory']}/#{node["blockchain"]["name"]}/params.dat
  EOH
end

template "#{node['app']['directory']}#{node['data']['directory']}/#{node["blockchain"]["name"]}/params.dat" do

  source "params.dat.erb"
  mode "644"
  owner "root"
  group "root"
  variables(
      :chain_name => node['blockchain']['name']
  )
  action :create_if_missing
end

bash 'initiate_new_chain' do
  code <<-EOH
    nohup /apps/multichaind -datadir=#{node['app']['directory']}#{node['data']['directory']} #{node["blockchain"]["name"]} -daemon > #{node['app']['directory']}#{node['data']['directory']}/logs.txt
  EOH
end


#to connect to the chain in interactive mode run
#sudo ./multichain-cli -datadir=/apps/datadir <chain-name>