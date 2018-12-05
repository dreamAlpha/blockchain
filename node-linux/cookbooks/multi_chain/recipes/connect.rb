template "#{node['app']['directory']}/start_node" do

  source "start_node.erb"
  mode "755"
  owner "root"
  group "root"
  variables(
      :chain_name => node['blockchain']['name'],
      :ip_address => node['blockchain']['ip'],
      :port_number => node['blockchain']['port'],
      :app_directory => node["app"]["directory"],
      :data_directory => node["data"]["directory"]
  )
  action :create_if_missing
end