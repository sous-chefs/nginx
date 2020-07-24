# site

Enable or disable a server block in `/etc/nginx/sites-available` by calling
nxensite or nxdissite (introduced by this cookbook) to manage the symbolic
link in `/etc/nginx/sites-enabled`.

```ruby
nginx_site 'site_name' do
  site_name String
  cookbook  String
  template  String
  variables Hash
end
```

## Actions

| Action  | Default  |
| ------- | -------- |
| :enable | &#x2713; |

## Properties

### `site_name`

Which site to enable or disable.

| property       | value  |
| -------------- | ------ |
| Type           | String |
| Default        | `name` |

### `cookbook`

Which cookbook to use for the template.

| property       | value   |
| -------------- | ------- |
| Type           | String  |
| Default        | `nginx` |

### `template`

Which template to use for the site.

| property       | value  |
| -------------- | ------ |
| Type           | String |
| Default        | `nil`  |

### `variables`

Additional variables to include in the site template.

This property is intended to allow specifying variables in
a template specified by the template or cookbook properties.
The variables that can be set in the default template
may all be set using the resource properties.

| property       | value |
| -------------- | ----- |
| Type           | Hash  |
| Default        | `{}`  |
