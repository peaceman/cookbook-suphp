package 'apache2-dev'

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:suphp][:download_filename]}" do
  source node[:suphp][:download_url]
  not_if { ::File.exists? "#{Chef::Config[:file_cache_path]}/#{node[:suphp][:download_filename]}" }
end

configure_options = %W{
--prefix=/usr
--with-setid-mode=#{node[:suphp][:setid_mode]}
--with-min-uid=#{node[:suphp][:min_uid]}
--with-min-gid=#{node[:suphp][:min_gid]}
--with-apache-user=#{node[:apache][:user]}
--with-logfile=#{node[:apache][:log_dir]}/suphp.log
--with-apxs=/usr/bin/apxs2
--with-apr=/usr/bin/apr-config
}

bash 'build and install suphp' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar -xf #{node[:suphp][:download_filename]}
    (cd #{node[:suphp][:download_filename].sub(/\.tar\.gz/, '')} && automake --add-missing && autoreconf})
    (cd #{node[:suphp][:download_filename].sub(/\.tar\.gz/, '')} && ./configure #{configure_options.join(' ')})
    (cd #{node[:suphp][:download_filename].sub(/\.tar\.gz/, '')} && make && make install)
  EOF

  not_if { ::File.exists?('/usr/sbin/suphp') }
end

%w{ suphp.load suphp.conf }.each do |filename|
  cookbook_file "#{node[:apache][:dir]}/mods-available/#{filename}" do
    source filename
  end
end
