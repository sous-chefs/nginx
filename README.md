# nginx Cookbook

[![Cookbook](http://img.shields.io/cookbook/v/nginx.svg)](https://supermarket.chef.io/cookbooks/nginx)

Installs nginx from package OR source code and sets up configuration handling similar to Debian's Apache2 scripts.

## Requirements

### Cookbooks

The following cookbooks are direct dependencies because they're used for common "default" functionality.

- `build-essential` for source installations
- `ohai` for setting up the ohai plugin
- `yum-epel` for setting up the EPEL repository on RHEL platforms
- `zypper` for setting up the nginx.org repository on Suse platforms

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

## Attributes

Node attributes for this cookbook are logically separated into different files. Some attributes are set only via a specific recipe.

### nginx::default

Generally used attributes. Some have platform specific values. See `attributes/default.rb`. "The Config" refers to "nginx.conf" the main config file.

- `node['nginx']['dir']` - Location for nginx configuration.
- `node['nginx']['conf_template']` - The `source` template to use when creating the `nginx.conf`.
- `node['nginx']['conf_cookbook']` - The cookbook where `node['nginx']['conf_template']` resides.
- `node['nginx']['log_dir']` - Location for nginx logs.
- `node['nginx']['log_dir_perm']` - Permissions for nginx logs folder.
- `node['nginx']['user']` - User that nginx will run as.
- `node['nginx']['user_home']` - User home path, used during user creation.
- `node['nginx']['group']` - Group for nginx.
- `node['nginx']['port']` - Port for nginx to listen on.
- `node['nginx']['binary']` - Path to the nginx binary.
- `node['nginx']['init_style']` - How to run nginx as a service when using `nginx::source`. Values can be "upstart", "systemd", or "init". This attribute is not used in the `package` recipe because the package manager's init script style for the platform is assumed.
- `node['nginx']['cleanup_runit']` - Cleanup existing runit based nginx service installation. Uses the `nginx_cleanup_runit` resource. Default: true
- `node['nginx']['upstart']['foreground']` - Set this to true if you want upstart to run nginx in the foreground, set to false if you want upstart to detach and track the process via pid.
- `node['nginx']['upstart']['runlevels']` - String of runlevels in the format '2345' which determines which runlevels nginx will start at when entering and stop at when leaving.
- `node['nginx']['upstart']['respawn_limit']` - Respawn limit in upstart stanza format, count followed by space followed by interval in seconds.
- `node['nginx']['keepalive']` - Whether to use `keepalive_timeout`, any value besides "on" will leave that option out of the config.
- `node['nginx']['keepalive_requests']` - used for config value of `keepalive_requests`.
- `node['nginx']['keepalive_timeout']` - used for config value of `keepalive_timeout`.
- `node['nginx']['worker_processes']` - used for config value of `worker_processes`.
- `node['nginx']['worker_connections']` - used for config value of `events { worker_connections }`
- `node['nginx']['worker_rlimit_nofile']` - used for config value of `worker_rlimit_nofile`. Can replace any "ulimit -n" command. The value depend on your usage (cache or not) but must always be superior than worker_connections.
- `node['nginx']['worker_shutdown_timeout']` - used for config value of `worker_shutdown_timeout`.
- `node['nginx']['worker_connections']` - used for config value of `events { worker_connections }`
- `node['nginx']['multi_accept']` - used for config value of `events { multi_accept }`. Try to accept() as many connections as possible. Disable by default.
- `node['nginx']['event']` - used for config value of `events { use }`. Set the event-model. By default nginx looks for the most suitable method for your OS.
- `node['nginx']['accept_mutex_delay']` - used for config value of `accept_mutex_delay`
- `node['nginx']['server_tokens']` - used for config value of `server_tokens`.
- `node['nginx']['server_names_hash_bucket_size']` - used for config value of `server_names_hash_bucket_size`.
- `node['nginx']['disable_access_log']` - set to true to disable the general access log, may be useful on high traffic sites.
- `node['nginx']['access_log_options']` - Set to a string of additional options to be appended to the access log directive
- `node['nginx']['error_log_options']` - Set to a string of additional options to be appended to the error log directive
- `node['nginx']['default_site_enabled']` - enable the default site
- `node['nginx']['sendfile']` - Whether to use `sendfile`. Defaults to "on".
- `node['nginx']['tcp_nopush']` - Whether to use `tcp_nopush`. Defaults to "on".
- `node['nginx']['tcp_nodelay']` - Whether to use `tcp_nodelay`. Defaults to "on".
- `node['nginx']['install_method']` - Whether nginx is installed from packages or from source.
- `node['nginx']['types_hash_max_size']` - Used for the `types_hash_max_size` configuration directive.
- `node['nginx']['types_hash_bucket_size']` - Used for the `types_hash_bucket_size` configuration directive.
- `node['nginx']['proxy_read_timeout']` - defines a timeout (between two successive read operations) for reading a response from the proxied server.
- `node['nginx']['client_body_buffer_size']` - used for config value of `client_body_buffer_size`.
- `node['nginx']['client_max_body_size']` - specifies the maximum accepted body size of a client request, as indicated by the request header Content-Length.
- `node['nginx']['repo_source']` - when installed from a package this attribute affects which yum repositories, if any, will be added before installing the nginx package. The default value of 'epel' will use the `yum-epel` cookbook, 'nginx' will use the `nginx::repo` recipe, 'passenger' will use the 'nginx::repo_passenger' recipe, and setting no value will not add any additional repositories.
- `node['nginx']['sts_max_age']` - Enable Strict Transport Security for all apps (See: <http://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security>). This attribute adds the following header: Strict-Transport-Security max-age=SECONDS to all incoming requests and takes an integer (in seconds) as its argument.
- `node['nginx']['default']['modules']` - Array specifying which modules to enable via the conf-enabled config include function. Currently the only valid value is "socketproxy".
- `node['nginx']['load_modules']` - Array of paths to modules to dynamically load on nginx startup using the `load_module` directive. Default is `[]`.

#### gzip module

- `node['nginx']['gzip']` - Whether to use gzip, can be "on" or "off"
- `node['nginx']['gzip_http_version']` - used for config value of `gzip_http_version`.
- `node['nginx']['gzip_comp_level']` - used for config value of `gzip_comp_level`.
- `node['nginx']['gzip_proxied']` - used for config value of `gzip_proxied`.
- `node['nginx']['gzip_vary']` - used for config value of `gzip_vary`.
- `node['nginx']['gzip_buffers']` - used for config value of `gzip_buffers`.
- `node['nginx']['gzip_types']` - used for config value of `gzip_types` - must be an Array.
- `node['nginx']['gzip_min_length']` - used for config value of `gzip_min_length`.
- `node['nginx']['gzip_disable']` - used for config value of `gzip_disable`.

#### Other configurations

- `node['nginx']['extra_configs']` - a Hash of key/values to nginx configuration.

### nginx::ohai_plugin

The `ohai_plugin` recipe includes an Ohai plugin. It will be automatically installed and activated, providing the following attributes via ohai, no matter how nginx is installed (source or package):

- `node['nginx']['version']` - version of nginx
- `node['nginx']['configure_arguments']` - options passed to `./configure` when nginx was built
- `node['nginx']['prefix']` - installation prefix
- `node['nginx']['conf_path']` - configuration file path
- `node['nginx']['ohai_plugin_enabled']` - Toggles ohai_plugin recipe. Defaults to true.

In the source recipe, it is used to determine whether control attributes for building nginx have changed.

### nginx::openssl_source

These attributes are used in the `nginx::openssl_source` recipe.

- `node['nginx']['openssl_source']['version']` - The version of OpenSSL you want to download and use (default: 1.0.1t)
- `node['nginx']['openssl_source']['url']` - The url for the OpenSSL source

### nginx::passenger

These attributes are used in the `nginx::passenger` recipe.

- `node['nginx']['passenger']['version']` - passenger gem version
- `node['nginx']['passenger']['root']` - passenger gem root path
- `node['nginx']['passenger']['install_rake']` - set to false if rake already present on system
- `node['nginx']['passenger']['max_pool_size']` - maximum passenger pool size (default=10)
- `node['nginx']['passenger']['ruby']` - Ruby path for Passenger to use (default=`$(which ruby)`)
- `node['nginx']['passenger']['spawn_method']` - passenger spawn method to use (default=`smart-lv2`)
- `node['nginx']['passenger']['buffer_response']` - turns on or off response buffering (default=`on`)
- `node['nginx']['passenger']['max_pool_size']` - passenger maximum pool size (default=`6`)
- `node['nginx']['passenger']['min_instances']` - minimum instances (default=`1`)
- `node['nginx']['passenger']['max_instances_per_app']` - maximum instances per app (default=`0`)
- `node['nginx']['passenger']['pool_idle_time']` - passenger pool idle time (default=`300`)
- `node['nginx']['passenger']['max_requests']` - maximum requests (default=`0`)
- `node['nginx']['passenger']['nodejs']` - Nodejs path for Passenger to use (default=nil)
- `node['nginx']['passenger']['show_version_in_header']` - Show passenger version in HTTP headers (default=`on`)

Basic configuration to use the official Phusion Passenger repositories:

- `node['nginx']['repo_source']` - 'passenger'
- `node['nginx']['package_name']` - 'nginx-extras'
- `node['nginx']['passenger']['install_method']` - 'package'

### nginx::rate_limiting

- `node['nginx']['enable_rate_limiting']` - set to true to enable rate limiting (`limit_req_zone` in nginx.conf)
- `node['nginx']['rate_limiting_zone_name']` - sets the zone in `limit_req_zone`.
- `node['nginx']['rate_limiting_backoff']` - **Incorrect name, retained for compatibility reasons** - sets the size of the shared memory zone (default=`10m`, 10 megabytes)
- `node['nginx']['rate_limit']` - set the rate limit amount for `limit_req_zone`.

### nginx::repo

- `node['nginx']['upstream_repository']` - the URL to use for the package repository resource; default is set based on platform type
- `node['nginx']['repo_signing_key']` - The URL from which package signing/gpg key is retrieved

### nginx::socketproxy

These attributes are used in the `nginx::socketproxy` recipe.

- `node['nginx']['socketproxy']['root']` - The directory (on your server) where socketproxy apps are deployed.
- `node['nginx']['socketproxy']['default_app']` - Static assets directory for requests to "/" that don't meet any proxy_pass filter requirements.
- `node['nginx']['socketproxy']['apps']['app_name']['prepend_slash']` - Prepend a slash to requests to app "app_name" before sending them to the socketproxy socket.
- `node['nginx']['socketproxy']['apps']['app_name']['context_name']` - URI (e.g. "app_name" in order to achieve "<http://mydomain.com/app_name>") at which to host the application "app_name"
- `node['nginx']['socketproxy']['apps']['app_name']['subdir']` - Directory (under `node['nginx']['socketproxy']['root']`) in which to find the application.

### nginx::source

These attributes are used in the `nginx::source` recipe. Some of them are dynamically modified during the run. See `attributes/source.rb` for default values.

- `node['nginx']['source']['url']` - (versioned) URL for the nginx source code. By default this will use the version specified as `node['nginx']['version']`.
- `node['nginx']['source']['prefix']` - (versioned) prefix for installing nginx from source
- `node['nginx']['source']['conf_path']` - location of the main config file, in `node['nginx']['dir']` by default.
- `node['nginx']['source']['modules']` - Array of modules that should be compiled into nginx by including their recipes in `nginx::source`.
- `node['nginx']['source']['default_configure_flags']` - The default flags passed to the configure script when building nginx.
- `node['nginx']['configure_flags']` - Preserved for compatibility and dynamically generated from the `node['nginx']['source']['default_configure_flags']` in the `nginx::source` recipe.
- `node['nginx']['source']['use_existing_user']` - set to `true` if you do not want `nginx::source` recipe to create system user with name `node['nginx']['user']` and `node['nginx']['user_home']`.

### nginx::syslog

These attributes are used in the `nginx::syslog_module` recipe.

- `node['nginx']['syslog']['git_repo']` - The git repository url to use for the syslog patches.
- `node['nginx']['syslog']['git_revision']` - The revision on the git repository to checkout.

### nginx::upload_progress

These attributes are used in the `nginx::upload_progress_module` recipe.

- `node['nginx']['upload_progress']['url']` - URL for the tarball.
- `node['nginx']['upload_progress']['checksum']` - Checksum of the tarball.
- `node['nginx']['upload_progress']['javascript_output']` - Output in javascript. Default is `true` for backwards compatibility.
- `node['nginx']['upload_progress']['zone_name']` - Zone name which will be used to store the per-connection tracking information. Default is `proxied`.
- `node['nginx']['upload_progress']['zone_size']` - Zone size in bytes. Default is `1m` (1 megabyte).

## Resources

- [nginx_install](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/install.md)
- [nginx_config](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/config.md)
- [nginx_site](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/site.md)

### nginx_stream

Enable or disable a Stream Block in `#{node['nginx']['dir']}/streams-available` by calling nxenstream or nxdisstream (introduced by this cookbook) to manage the symbolic link in `#{node['nginx']['dir']}/streams-enabled`.

### Actions

- `enable` - Enable the nginx stream (default)
- `disable` - Disable the nginx stream

### Properties

- `stream_name` - (optional) Name of the stream to enable.
- `template` - (optional) Path to the source for the `template` resource.
- `variables` - (optional) Variables to be used with the `template` resource

### nginx_cleanup_runit

A simple resource to remove existing runit based nginx service installations. This is used in the default nginx recipe to stop runit based nginx services and cleanup runit service configs before setting up nginx under the system's own init system.

### Actions

- `cleanup` - Stop runit based nginx and remove runit configs (default)

## Usage

This cookbook provides three distinct installation methods, all of which are controlled via attributes and executed using the nginx::default recipe.

### Package installation using the nginx.org repositories

Nginx provides repositories for RHEL, Debian/Ubuntu, and Suse platforms with up to date packages available on older distributions. Due to the age of many nginx packages shipping with distros we believe this is the ideal installation method. With no attributes set the nginx.org repositories will be added to your system and nginx will be installed via package. This provides a solid out of the box install for most users.

### Package installation using distro repositories

If you prefer to use the packages included in your distro or to roll your own packages you'll want to set `node['nginx']['repo_source']` to `nil` or `distro` to skip the repository setup. The default recipe will still install nginx from packages, but you'll retain control over the package location.

### Source installation to compile non-dynamic modules

If you need control over how nginx is built, or you need non-dynamic modules to be included you'll need to compile nginx from source. We highly recommend against using this method as it requires the installation of a full compilation toolchain and development dependencies on your nodes. Creating your own packages with nginx compiled as necessary is a preferred option. If that's not possible you can set `node['nginx']['install_method']` to `source` and provide a version in `node['nginx']['version']`.

#### Specifying Modules to compile

The following recipes are used to build module support into nginx. To compile a module, add its recipe name to the array attribute `node['nginx']['source']['modules']`.

- `ipv6.rb` - enables IPv6 support
- `ipv6` -
- `openssl_source.rb` - downloads and uses custom OpenSSL source when compiling nginx
- `passenger` - builds the passenger gem and configuration for "`mod_passenger`".
- `set_misc` -
- `syslog_module` - enables syslog support for nginx. This only works with source builds. See <https://github.com/yaoweibin/nginx_syslog_patch> -
- `upload_progress_module.rb` - builds the `upload_progress` module and enables it as a module when compiling nginx.

## Adding New Modules

Previously we'd add each possible module to this cookbook itself. That's not necessary using wrapper cookbooks and we'd prefer to not add any addition module recipes at this time. Instead in your nginx wrapper cookbook setup any necessary packages and then include the follow code to add the module to the list of modules to compile:

```ruby
node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ['--with-SOMETHING', "--with-SOME_OPT='things'"]
```

## License

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
