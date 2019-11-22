# nginx Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/nginx.svg)](https://supermarket.chef.io/cookbooks/nginx)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/nginx/master.svg)](https://circleci.com/gh/sous-chefs/nginx)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs nginx from package and sets up configuration handling similar to Debian's Apache2 scripts.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Cookbooks

The following cookbooks are direct dependencies because they're used for common "default" functionality.

- `ohai` for setting up the ohai plugin

### Platforms

The following platforms are supported and tested with Test Kitchen:

- Amazon Linux 2
- CentOS 7
- Debian 8+
- openSuSE Leap 15
- Ubuntu 16.04+

Other Debian and RHEL family distributions are assumed to work.

### Chef

- Chef 14+

## Resources

- [nginx_install](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/install.md)
- [nginx_config](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/config.md)
- [nginx_site](https://github.com/sous-chefs/nginx/blob/master/documentation/resources/site.md)

## Usage

This cookbook is now resource-based. Use the resources described below in your recipes.

## Resources

### nginx_install

The `install` resource in this cookbook provides four methods for installing nginx via the `source` property, `distro`, `repo`, `epel`, `passenger`.

### Package installation using distro repositories

If you prefer to use the packages included in your distro or to roll your own packages you'll want to use `distro` as the `source` of your install to skip setting up additional repositories. This will give you control over the package locations, as the install will default to what repos are already set up on your node.
```
nginx_install 'MySite' do
  source 'distro'
end
```

Note: if your distro has no candidate version of nginx available, this resource will fail.

### Package installation using the nginx.org repositories

Nginx provides repositories for RHEL, Debian/Ubuntu, and SuSE platforms with up to date packages available on older distributions. Due to the age of many nginx packages shipping with distros we believe this is the ideal installation method. With no attributes set the nginx.org repositories will be added to your system and nginx will be installed via package. This provides a solid out of the box install for most users.
```
nginx_install 'MySite' do
  source 'repo'
end
```

### Package installation using EPEL

The Extra Packages for Enterprise Linux repositories provide nginx packages for RPM-based Linux systems. These are packaged differently from the nginx packages in the nginx repo, but may be suitable for your needs. Using the `epel` source will configure your `yum` for the `epel` and `epel-testing` repos, and install nginx packages from that origin.
```
nginx_install 'MySite' do
  source 'epel'
end
```

For more information about EPEL, see the [EPEL website](https://fedoraproject.org/wiki/EPEL). 

### Package installation for nginx with Passenger

To install nginx with Phusion Passenger runtime support, use the `passenger` source. **NOTE** This cookbook only supports installing Passenger on Debian/Ubuntu systems. To install Passenger on other systems, please refer to the [Passenger website](https://www.phusionpassenger.com). 

``` 
nginx_install 'MySite' do
  source 'passenger'
end
```

### Additional documentation
The `nginx_install`, `nginx_site`, and `nginx_config` resources have their own documentation in the [`documentation/resources`](documentation/resources) directory of this cookbook. 

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
