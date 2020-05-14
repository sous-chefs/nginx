# install

Installs nginx via distro, repo, epel or passenger source.

```ruby
nginx_install 'default' do
  ohai_plugin_enabled                   [true, false]
  source                                String
  default_site_enabled                  [true, false]
  conf_cookbook                         String
  conf_template                         String
  conf_variables                        Hash
  group                                 String
  worker_processes                      [Integer, String]
  worker_connections                    [Integer, String]
  sendfile                              String
  tcp_nopush                            String
  tcp_nodelay                           String
  keepalive_timeout                     [Integer, String]
  types_hash_max_size                   [Integer, String]
  default_site_cookbook                 String
  default_site_template                 String
  default_site_variables                Hash
  port                                  [Integer, String]
  server_name                           String
  install_rake                          String
  passenger_root                        String
  passenger_ruby                        String
  passenger_max_pool_size               [Integer, String]
  passenger_spawn_method                String
  passenger_buffer_response             String
  passenger_min_instances               String
  passenger_max_instances_per_app       String
  passenger_pool_idle_time              [Integer, String]
  passenger_max_requests                [Integer, String]
  passenger_show_version_in_header      String
  passenger_log_file                    String
  passenger_disable_anonymous_telemetry String
  passenger_anonymous_telemetry_proxy   String
  passenger_nodejs                      String
end
```

## Actions

| Action     | Default  |
| ---------- | -------- |
| `:install` | &#x2713; |

## Properties

### `ohai_plugin_enabled`

Whether or not ohai_plugin is enabled.

| property       | value         |
| -------------- | ------------- |
| Type           | [true, false] |
| Default        | `true`        |
| Allowed Values | true, false   |

### `source`

Source for installation.

| property       | value                         |
| -------------- | ----------------------------- |
| Type           | String                        |
| Default        | `name_property`               |
| Allowed Values | distro, repo, epel, passenger |

### `default_site_enabled`

Whether or not the default site is enabled.

| property       | value         |
| -------------- | ------------- |
| Type           | [true, false] |
| Default        | `true`        |
| Allowed Values | true, false   |

### `conf_cookbook`

Which cookbook to use for the conf template.

| property | value   |
| -------- | ------- |
| Type     | String  |
| Default  | `nginx` |

### `conf_template`

Which template to use for the conf.

| property | value            |
| -------- | ---------------- |
| Type     | String           |
| Default  | `nginx.conf.erb` |

### `conf_variables`

Additional variables to include in conf template.

| property | value |
| -------- | ----- |
| Type     | Hash  |
| Default  | `{}`  |

### `group`

Nginx group, if different than user.

| property | value                 |
| -------- | --------------------- |
| Type     | String                |
| Default  | `lazy { nginx_user }` |

### `worker_processes`

The number of worker processes.

| property | value             |
| -------- | ----------------- |
| Type     | [Integer, String] |
| Default  | `auto`            |

### `worker_connections`

The maximum number of simultaneous connections that can be opened by a worker process.

| property | value             |
| -------- | ----------------- |
| Type     | [Integer, String] |
| Default  | `1_024`           |

### `sendfile`

Enables or disables the use of sendfile().

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `on`    |
| Allowed Values | on, off |

### `tcp_nopush`

Enables or disables the use of the TCP_CORK socket option on Linux.

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `on`    |
| Allowed Values | on, off |

### `tcp_nodelay`

Enables or disables the use of the TCP_NODELAY option.

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `on`    |
| Allowed Values | on, off |

### `keepalive_timeout`

Timeout during which a keep-alive client connection will stay open on the server side.

| property | value             |
| -------- | ----------------- |
| Type     | [Integer, String] |
| Default  | `65`              |

### `types_hash_max_size`

Sets the maximum size of the types hash tables.

| property | value             |
| -------- | ----------------- |
| Type     | [Integer, String] |
| Default  | `2_048`           |

### `default_site_cookbook`

Which cookbook to use for the default site template.

| property | value   |
| -------- | ------- |
| Type     | String  |
| Default  | `nginx` |

### `default_site_template`

Which template to use for the default site.

| property | value              |
| -------- | ------------------ |
| Type     | String             |
| Default  | `default-site.erb` |

### `default_site_variables`

Additional variables to include in default site template.

| property | value |
| -------- | ----- |
| Type     | Hash  |
| Default  | `{}`  |

### `port`

Port to listen on.

| property | value                                        |
| -------- | -------------------------------------------- |
| Type     | [Integer, String]                            |
| Default  | `80`                                         |
| Coerce   | `proc { |v| v.is_a?(Integer) ? v.to_s : v }` |

### `server_name`

Sets the server_name directive.

| property | value                       |
| -------- | --------------------------- |
| Type     | String                      |
| Default  | `lazy { node['hostname'] }` |

### `install_rake`

Whether or not to install rake.

| property       | value         |
| -------------- | ------------- |
| Type           | [true, false] |
| Default        | `true`        |
| Allowed Values | true, false   |

### `passenger_root`

Passenger root.

| property | value                                                       |
| -------- | ----------------------------------------------------------- |
| Type     | String                                                      |
| Default  | `/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini` |

### `passenger_ruby`

Passenger ruby.

| property | value           |
| -------- | --------------- |
| Type     | String          |
| Default  | `/usr/bin/ruby` |

### `passenger_max_pool_size`

Passenger max pool size.

| property | value                                        |
| -------- | -------------------------------------------- |
| Type     | [Integer, String ]                           |
| Default  | `6`                                          |
| Coerce   | `proc { |v| v.is_a?(Integer) ? v.to_s : v }` |

### `passenger_spawn_method`

Passenger spawn method.

| property | value       |
| -------- | ----------- |
| Type     | String      |
| Default  | `smart-lv2` |

### `passenger_buffer_response`

Passenger buffer response.

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `on`    |
| Allowed Values | on, off |

### `passenger_min_instances`

Passenger minimum instances.

| property | value                                        |
| -------- | -------------------------------------------- |
| Type     | [Integer, String ]                           |
| Default  | `1`                                          |
| Coerce   | `proc { |v| v.is_a?(Integer) ? v.to_s : v }` |

### `passenger_max_instances_per_app`

Passenger minimum instances.

| property | value                                        |
| -------- | -------------------------------------------- |
| Type     | [Integer, String ]                           |
| Default  | `0`                                          |
| Coerce   | `proc { |v| v.is_a?(Integer) ? v.to_s : v }` |

### `passenger_pool_idle_time`

Passenger pool idle time.

| property | value                                        |
| -------- | -------------------------------------------- |
| Type     | [Integer, String ]                           |
| Default  | `300`                                        |
| Coerce   | `proc { |v| v.is_a?(Integer) ? v.to_s : v }` |

### `passenger_max_requests`

Passenger maximum requests.

| property | value                                        |
| -------- | -------------------------------------------- |
| Type     | [Integer, String ]                           |
| Default  | `0`                                          |
| Coerce   | `proc { |v| v.is_a?(Integer) ? v.to_s : v }` |

### `passenger_show_version_in_header`

Passenger show version in header.

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `on`    |
| Allowed Values | on, off |

### `passenger_log_file`

Passenger log file.

| property | value  |
| -------- | ------ |
| Type     | String |
| Default  | `nil`  |

### `passenger_disable_anonymous_telemetry`

Passenger turn disabling of anonymous telemetry on or off.

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `off`   |
| Allowed Values | on, off |

### `passenger_anonymous_telemetry_proxy`

Passenger set an intermediate proxy for anonymous telemetry.

| property | value  |
| -------- | ------ |
| Type     | String |
| Default  | `nil`  |

### `passenger_nodejs`

Passenger nodejs.

| property | value  |
| -------- | ------ |
| Type     | String |
| Default  | `nil`  |

## Examples

### Package installation using distro repositories

If you prefer to use the packages included in your distro or to roll your own packages you'll want to use `distro` as the `source` of your install to skip setting up additional repositories. This will give you control over the package locations, as the install will default to what repos are already set up on your node.

```ruby
nginx_install 'MySite' do
  source 'distro'
end
```

Note: if your distro has no candidate version of nginx available, this resource will fail.

### Package installation using the nginx.org repositories

Nginx provides repositories for RHEL, Debian/Ubuntu, and SuSE platforms with up to date packages available on older distributions. Due to the age of many nginx packages shipping with distros we believe this is the ideal installation method. With no attributes set the nginx.org repositories will be added to your system and nginx will be installed via package. This provides a solid out of the box install for most users.

```ruby
nginx_install 'MySite' do
  source 'repo'
end
```

### Package installation using EPEL

The Extra Packages for Enterprise Linux repositories provide nginx packages for RPM-based Linux systems. These are packaged differently from the nginx packages in the nginx repo, but may be suitable for your needs. Using the `epel` source will configure your `yum` for the `epel` and `epel-testing` repos, and install nginx packages from that origin.

```ruby
nginx_install 'MySite' do
  source 'epel'
end
```

For more information about EPEL, see the [EPEL website](https://fedoraproject.org/wiki/EPEL).

### Package installation for nginx with Passenger

To install nginx with Phusion Passenger runtime support, use the `passenger` source. **NOTE** This cookbook only supports installing Passenger on Debian/Ubuntu systems. To install Passenger on other systems, please refer to the [Passenger website](https://www.phusionpassenger.com).

```ruby
nginx_install 'MySite' do
  source 'passenger'
end
```
