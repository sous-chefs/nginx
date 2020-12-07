# nginx_install

[Back to resource list](../README.md#resources)

Installs nginx via distro, repo, or EPEL.

## Actions

- `:install`
- `:remove`

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `ohai_plugin_enabled`  | True, False   | `true`                           | Install the nginx ohai plugin.                                      |                     |
| `source`               | String        | `distro`                         | Source to install Nginx from.                                       |`distro`, `repo`, `epel`|
| `repo_train`           | String        | `distro`                         | Train to use for installation from nginx repoistory.                |`stable`, `mainline` |
| `packages`             | String, Array | Platform specific                | Packages to install/remove.                                         |                     |
| `packages_versions`    | String, Array | `nil`                            | Package versions to install/remove.                                 |                     |

## Examples

### Package installation using distro repositories

If you prefer to use the packages included in your distro or to roll your own packages you'll want to use `distro` as the `source` of your install to skip setting up additional repositories. This will give you control over the package locations, as the install will default to what repos are already set up on your node.

```ruby
nginx_install 'nginx' do
  source 'distro'
end
```

Note: if your distro has no candidate version of nginx available, this resource will fail.

### Package installation using the nginx.org repositories

Nginx provides repositories for RHEL, Debian/Ubuntu, and SuSE platforms with up to date packages available on older distributions. Due to the age of many nginx packages shipping with distros we believe this is the ideal installation method. With no attributes set the nginx.org repositories will be added to your system and nginx will be installed via package. This provides a solid out of the box install for most users.

```ruby
nginx_install 'nginx' do
  source 'repo'
end
```

### Package installation using EPEL

The Extra Packages for Enterprise Linux repositories provide nginx packages for RPM-based Linux systems. These are packaged differently from the nginx packages in the nginx repo, but may be suitable for your needs. Using the `epel` source will configure your `yum` for the `epel` and `epel-testing` repos, and install nginx packages from that origin.

```ruby
nginx_install 'nginx' do
  source 'epel'
end
```

For more information about EPEL, see the [EPEL website](https://fedoraproject.org/wiki/EPEL).
