if platform_family?('debian')
  package 'ca-certificates'

  apt_repository 'phusionpassenger' do
    uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
    distribution node['lsb']['codename']
    components %w(main)
    deb_src true
    keyserver 'keyserver.ubuntu.com'
    key '561F9B9CAC40B2F7'
  end
else
  log "There is not official phusion passenger repo platform #{node['platform']}. Skipping repo setup!" do
    level :warn
  end
end
