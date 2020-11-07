# nginx_site

[Back to resource list](../README.md#resources)

## Actions

- `:create` - Create an nginx site configuration file
- `:delete` - Delete an nginx site configuration file

## Properties

| Name                   | Type          | Default                          | Description                                                         |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- |
| `config_dir`           | String        | `/etc/nginx/conf.sites.d`        | Directory to create configuration file in                           |
| `cookbook`             | String        | `syslog-ng`                      | Cookbook to source configuration file template from                 |
| `template`             | String        | `syslog-ng/destination.conf.erb` | Template to use to generate the configuration file                  |
| `variables`            | Hash          | `{}`                             | Additional variables to include in site template                    |

## Usage

### Example

```ruby
nginx_site 'test_site' do
  template 'default-site.erb'
  variables(
    'port': 80,
    'server_name': 'test_site',
    'default_root': '/var/www/nginx-default',
    'nginx_log_dir': '/var/log/nginx'
  )
  action :create
  notifies :reload, 'nginx_service[nginx]', :delayed
end
```
