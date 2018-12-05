template "#{node['app']['directory']}/start_node.bat" do

  source "start_node_bat.erb"
  variables(
      :chain_name => node['blockchain']['name'],
      :ip_address => node['blockchain']['ip'],
      :port_number => node['blockchain']['port'],
      :app_directory => node["app"]["directory"],
      :data_directory => node["data"]["directory"]
  )
  action :create_if_missing
end