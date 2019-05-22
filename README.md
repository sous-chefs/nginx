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
