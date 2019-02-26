%w(nxensite nxdissite nxenstream nxdisstream).each do |nxscript|
  template "#{node['nginx']['script_dir']}/#{nxscript}" do
    source "#{nxscript}.erb"
    mode   '0755'
  end
end
