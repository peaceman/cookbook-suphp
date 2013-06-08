default[:suphp][:version] = '0.7.2'
default[:suphp][:download_filename] = "suphp-#{node[:suphp][:version]}.tar.gz"
default[:suphp][:download_url] = "http://www.suphp.org/download/#{node[:suphp][:download_filename]}"
default[:suphp][:setid_mode] = 'paranoid'
default[:suphp][:min_uid] = 1000
default[:suphp][:min_gid] = 100