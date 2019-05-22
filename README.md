# nginx Cookbook

[![Cookbook](http://img.shields.io/cookbook/v/nginx.svg)](https://supermarket.chef.io/cookbooks/nginx)

Installs nginx from package and sets up configuration handling similar to Debian's Apache2 scripts.

## Requirements

### Cookbooks

The following cookbooks are direct dependencies because they're used for common "default" functionality.

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

### nginx::repo

- `node['nginx']['upstream_repository']` - the URL to use for the package repository resource; default is set based on platform type
- `node['nginx']['repo_signing_key']` - The URL from which package signing/gpg key is retrieved

## Resources

- [nginx_install](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/install.md)
- [nginx_config](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/config.md)
- [nginx_site](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/site.md)

## Usage

This cookbook provides three distinct installation methods, all of which are controlled via attributes and executed using the nginx::default recipe.

### Package installation using the nginx.org repositories

Nginx provides repositories for RHEL, Debian/Ubuntu, and Suse platforms with up to date packages available on older distributions. Due to the age of many nginx packages shipping with distros we believe this is the ideal installation method. With no attributes set the nginx.org repositories will be added to your system and nginx will be installed via package. This provides a solid out of the box install for most users.

### Package installation using distro repositories

If you prefer to use the packages included in your distro or to roll your own packages you'll want to set `node['nginx']['repo_source']` to `nil` or `distro` to skip the repository setup. The default recipe will still install nginx from packages, but you'll retain control over the package location.

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
