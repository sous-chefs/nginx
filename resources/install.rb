property :skip_repo, [TrueClass, FalseClass], default: false
property :package_name, String, default: 'nginx'

action_class do
  # setup the appropriate repo
  def create_repo
    case node['platform_family']
    when 'debian'
      apt_nginx_repo
    when 'rhel'
      yum_nginx_repo
    when 'suse'
      Chef::Log.fail('SUSE repo setup not yet implemented.')
      raise
    else
      Chef::Log.fail("There is not a Nginx.org repository for the platfrom #{node['platform']}. Set the use_repository property to false in the nginx_install resource and provide you're own nginx package source")
      raise
    end
  end

  def yum_nginx_repo
    yum_repository 'nginx' do
      description 'nginx.org repository'
      baseurl "http://nginx.org/packages/#{platform?('redhat') ? 'rhel' : 'centos'}/#{node['platform_version'].to_i}/$basearch/"
      gpgkey 'http://nginx.org/keys/nginx_signing.key'
    end
  end

  def apt_nginx_repo
    apt_repository 'nginx' do
      uri "http://nginx.org/packages/#{platform?('ubuntu') ? 'ubuntu' : 'debian'}/"
      distribution node['lsb']['codename']
      components ['nginx']
      key 'http://nginx.org/keys/nginx_signing.key'
    end
  end
end

action :install do
  create_repo unless new_resource.skip_repo

  package new_resource.package_name
end
