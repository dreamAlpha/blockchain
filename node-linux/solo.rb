Chef::Config.ssl_verify_mode = :verify_peer
current_dir       = File.expand_path(File.dirname(__FILE__)) 
file_cache_path   "#{current_dir}" 
cookbook_path     "#{current_dir}/cookbooks"
