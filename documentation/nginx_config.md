# config

[Back to resource list](../README.md#resources)

## Actions

- `:create`
- `:delete`

## Properties

| Name                   | Type          | Default                          | Description                                                         |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- |
| `config_file`          | String        | `/etc/nginx/nginx.conf`          | The full path to the Nginx server configuration on disk.            |
| `conf_cookbook`        | String        | `nginx`                          | Which cookbook to use for the configuration template.               |
| `conf_template`        | String        | `nginx.conf.erb`                 | Which template to use for the configuration file.                   |
| `conf_variables`       | Hash          | `{}`                             | Additional variables to include in conf template.                   |
| `port`                 | Integer, String | `80`                           | Port to listen on.                                                  |
| `server_name`          | String        | `node['hostname']`               | Sets the server_name directive.                                     |
| `owner`                | String        | `root`                           | Nginx file/folder owner.                                            |
| `group`                | String        | `root`                           | Nginx run-as/file/folder group.                                     |
| `mode`                 | String        | `0640`                           | Nginx configuration file mode.                                      |
| `folder_mode`          | String        | `0750`                           | Nginx configuration folder mode.                                    |
| `process_user`         | String        | `www-data` (Debian) or `nginx`   | Nginx run-as user.                                                  |
| `process_group`        | String        | `www-data` (Debian) or `nginx`   | Nginx run-as group.                                                 |
| `worker_processes`     | Integer, String | `auto`                         | The number of worker processes.                                     |
| `worker_connections`   | Integer, String | `1_024`                        | The maximum number of simultaneous connections that can be opened by a worker process.|
| `sendfile`             | String        | `on`                             | Enables or disables the use of sendfile().                          |
| `tcp_nopush`           | String        | `on`                             | Enables or disables the use of the TCP_CORK socket option on Linux. |
| `tcp_nodelay`          | String        | `on`                             | Enables or disables the use of the TCP_NODELAY option.              |
| `keepalive_timeout`    | Integer, String | `65`                           | Timeout during which a keep-alive client connection will stay open on the server side.|
| `types_hash_max_size`  | Integer, String | `2_048`                        | Sets the maximum size of the types hash tables.on Linux.            |
| `default_site_enabled` | True, False   | `true`                           | Whether or not the default site is enabled.                         |
| `default_site_cookbook`| String        | `nginx`                          | Which cookbook to use for the default site template.                |
| `default_site_template`| String        | `default-site.erb`               | Which template to use for the default site.                         |
| `template_helpers`     | String, Array | `nil`                            | Additional helper modules to include in the default site and config template. |

## Examples

```ruby
nginx_config 'nginx' do
  action :create
  notifies :reload, 'nginx_service[nginx]', :delayed
end
```
