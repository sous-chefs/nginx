# nginx_site

[Back to resource list](../README.md#resources)

## Actions

- `:create` - Create an nginx site configuration file
- `:delete` - Delete an nginx site configuration file
- `:enable` - Enable a pre-existing configuration file
- `:disable` - Disable a pre-existing configuration file

## Properties

| Name               | Type          | Default                  | Description                                               |
|--------------------|---------------|--------------------------|-----------------------------------------------------------|
| `conf_dir`         | String        | `/etc/nginx/conf.http.d` | Directory to create configuration file in                 |
| `cookbook`         | String        | `nginx`                  | Cookbook to source configuration file template from       |
| `template`         | String        | `site-template.erb`      | Template to use to generate the configuration file        |
| `owner`            | String        | `root`                   | Nginx configuration file/folder owner.                    |
| `group`            | String        | `root`                   | Nginx configuration file/folder group.                    |
| `mode`             | String        | `0640`                   | Nginx configuration file mode.                            |
| `folder_mode`      | String        | `0750`                   | Nginx configuration folder mode.                          |
| `variables`        | Hash          | `{}`                     | Additional variables to include in site template          |
| `template_helpers` | String, Array | `nil`                    | Additional helper modules to include in the site template |

## Usage

### Example

#### Using the default template

```ruby
nginx_site 'test_site' do
  mode '0644'

  variables(
    'server' => {
      'listen' => [ '*:80' ],
      'server_name' => [ 'test_site' ],
      'access_log' => '/var/log/nginx/test_site.access.log',
      'locations' => {
        '/' => {
          'root' => '/var/www/nginx-default',
          'index' => 'index.html index.htm',
        },
      },
    }
  )

  action :create
  notifies :reload, 'nginx_service[nginx]', :delayed
end
```

#### Overriden template and disabled

```ruby
nginx_site 'test_site_disabled' do
  template 'default-site.erb'

  variables(
    'port': 80,
    'server_name': 'test_site',
    'default_root': '/var/www/nginx-default',
    'nginx_log_dir': '/var/log/nginx'
  )
  action [:create, :disable]
  notifies :reload, 'nginx_service[nginx]', :delayed
end
```
