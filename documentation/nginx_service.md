# nginx_service

[Back to resource list](../README.md#resources)

## Actions

- `:start`
- `:stop`
- `:restart`
- `:reload`
- `:enable`
- `:disable`

## Properties

| Name                   | Type          | Default                          | Description                                                         |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- |
| `service_name`         | String        | `nginx`                          | The service name to perform actions upon                            |
| `config_test`          | True, False   | `true`                           | Perform a configuration file test before performing service action  |

## Usage

### Example

```ruby
nginx_service 'nginx' do
  action :enable
  delayed_action :start
end
```

### Example - Skip configuration test

```ruby
nginx_service 'nginx' do
  config_test false

  action :enable
  delayed_action :start
end
```
