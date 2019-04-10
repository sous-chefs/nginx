property :ohai_plugin_enabled, [true, false],
         description: 'Whether or not ohai_plugin is enabled.',
         equal_to: [true, false],
         default: true

property :source, String,
         description: 'Source for installation.',
         equal_to: %w(distro),
         name_property: true

action :install do
  if ohai_plugin_enabled?
    ohai 'reload_nginx' do
      plugin 'nginx'
      action :nothing
    end

    ohai_plugin 'nginx' do
      cookbook    'nginx'
      source_file 'plugins/ohai-nginx.rb.erb'
      resource    :template
      variables(
        binary: nginx_binary
      )
    end
  end

  case new_resource.source
  when 'distro'
    log 'Using distro provided packages.'
  end

  package 'nginx' do
    notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
  end

  service 'nginx' do
    supports status: true, restart: true, reload: true
    action   [:start, :enable]
  end
end

action_class do
  def ohai_plugin_enabled?
    new_resource.ohai_plugin_enabled
  end
end
