# install

Installs nginx via distro source.

```ruby
nginx_install 'default' do
  ohai_plugin_enabled    [true, false]
  source                 String
  default_site_enabled   [true, false]
  conf_cookbook          String
  conf_template          String
  conf_variables         Hash
  group                  String
  worker_processes       [Integer, String]
  worker_connections     [Integer, String]
  sendfile               String
  tcp_nopush             String
  tcp_nodelay            String
  keepalive_timeout      [Integer, String]
  types_hash_max_size    [Integer, String]
  default_site_cookbook  String
  default_site_template  String
  default_site_variables Hash
  port                   [Integer, String]
  server_name            String
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

| property       | value              |
| -------------- | ------------------ |
| Type           | String             |
| Default        | `name_property`    |
| Allowed Values | distro, repo, epel |

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
