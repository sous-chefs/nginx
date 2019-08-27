# nginx Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/nginx.svg)](https://supermarket.chef.io/cookbooks/nginx)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/nginx/master.svg)](https://circleci.com/gh/sous-chefs/nginx)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs nginx from package and sets up configuration handling similar to Debian's Apache2 scripts.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Cookbooks

The following cookbooks are direct dependencies because they're used for common "default" functionality.

- `ohai` for setting up the ohai plugin

### Platforms

The following platforms are supported and tested with Test Kitchen:

- Amazon Linux 2
- CentOS 7
- Debian 8+
- openSUSE Leap 15
- Ubuntu 16.04+

Other Debian and RHEL family distributions are assumed to work.

### Chef

- Chef 14+

## Resources

- [nginx_install](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/install.md)
- [nginx_config](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/config.md)
- [nginx_site](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/site.md)

## Usage

This cookbook provides three distinct installation methods, all of which are controlled via attributes and executed using the nginx::default recipe.


## Usage Note

It is recommended to create a project or organization specific [wrapper cookbook](https://www.chef.io/blog/2013/12/03/doing-wrapper-cookbooks-right/) and add the desired custom resources to the run list of a node. Depending on your environment, you may have multiple roles that use different recipes from this cookbook. Adjust any attributes as desired.

```ruby
# service['nginx'] is defined in the nginx_install resource but other resources are currently unable to reference it.  To work around this issue, define the following helper in your cookbook:
service 'nginx' do
  extend Nginx::Cookbook::Helpers
  supports restart: true, status: true, reload: true
  action :nothing
end

nginx_install 'distro'

siteconfig = { 'port': 80,
               'server_name': 'test_site',
               'default_root': '/var/www/test_site',
               'nginx_log_dir': '/var/log/nginx',
}
nginx_site 'test_site' do
  site_name 'test_site'
  template 'custom-nginx-site-template.erb'
  cookbook 'my-wrapper-cookbook'
  variables siteconfig
  action :enable
end
```


### Package installation using the nginx.org repositories

Nginx provides repositories for RHEL, Debian/Ubuntu, and Suse platforms with up to date packages available on older distributions. Due to the age of many nginx packages shipping with distros we believe this is the ideal installation method. With no attributes set the nginx.org repositories will be added to your system and nginx will be installed via package. This provides a solid out of the box install for most users.

### Package installation using distro repositories

If you prefer to use the packages included in your distro or to roll your own packages you'll want to set `node['nginx']['repo_source']` to `nil` or `distro` to skip the repository setup. The default recipe will still install nginx from packages, but you'll retain control over the package location.

### Source installation to compile non-dynamic modules

If you need control over how nginx is built, or you need non-dynamic modules to be included you'll need to compile nginx from source. We highly recommend against using this method as it requires t  he installation of a full compilation toolchain and development dependencies on your nodes. Creating your own packages with nginx compiled as necessary is a preferred option. If that's not possible you can set `node['nginx']['install_method']` to `source` and provide a version in `node['nginx']['version']`.

#### Specifying Modules to compile

The following recipes are used to build module support into nginx. To compile a module, add its recipe name to the array attribute `node['nginx']['source']['modules']`.

- `ipv6.rb` - enables IPv6 support
- `headers_more_module` -
- `http_auth_request_module``
- `http_echo_module.rb` - downloads the `http_echo_module` module and enables it as a module when compiling nginx.
- `http_geoip_module.rb` - installs the GeoIP libraries and data files and enables the module for compilation.
- `http_gzip_static_module.rb` - enables the module for compilation. Be sure to set `node['nginx']['gzip_static'] = 'yes'`.
- `http_mp4_module` -
- `http_perl_module.rb` - enables embedded Perl for compilation.
- `http_realip_module.rb` - enables the module for compilation and creates the configuration.
- `http_spdy_module` -
- `http_ssl_module.rb` - enables SSL for compilation.
- `http_stub_status_module.rb` - provides `nginx_status` configuration and enables the module for compilation.
- `http_v2_module`
- `ipv6` -
- `naxsi_module` - enables the naxsi module for the web application firewall for nginx.
- `ngx_devel_module` -
- `ngx_lua_module` -
- `openssl_source.rb` - downloads and uses custom OpenSSL source when compiling nginx
- `pagespeed_module`-
- `passenger` - builds the passenger gem and configuration for "`mod_passenger`".
- `set_misc` -
- `syslog_module` - enables syslog support for nginx. This only works with source builds. See <https://github.com/yaoweibin/nginx_syslog_patch> -
- `upload_progress_module.rb` - builds the `upload_progress` module and enables it as a module when compiling nginx.

## Resources

### nginx_site

Enable or disable a Server Block in `#{node['nginx']['dir']}/sites-available` by calling nxensite or nxdissite (introduced by this cookbook) to manage the symbolic link in `#{node['nginx']['dir']}/sites-enabled`.

### Actions

- `enable` - Enable the nginx site (default)
- `disable` - Disable the nginx site

### Properties

- `name` - (optional) Name of the site to enable. By default it's assumed that the name of the nginx_site resource is the site name, but this allows overriding that.
- `template` - (optional) Path to the source for the `template` resource.
- `cookbook` - (optional) The cookbook that contains the template source.
- `variables` - (optional) Variables to be used with the `template` resource

## Adding New Modules

Previously we'd add each possible module to this cookbook itself. That's not necessary using wrapper cookbooks and we'd prefer to not add any addition module recipes at this time. Instead in your nginx wrapper cookbook set up any necessary packages and then include the follow code to add the module to the list of modules to compile:

```ruby
node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ['--with-SOMETHING', "--with-SOME_OPT='things'"]
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
