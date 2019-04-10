# install

Installs nginx via distro source.

```ruby
nginx_install 'default' do
  ohai_plugin_enabled  [true, false]
  source               String
  default_site_enabled [true, false]
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
