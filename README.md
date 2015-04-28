nginx Cookbook
==============
[![Cookbook](http://img.shields.io/cookbook/v/nginx.svg)](https://github.com/miketheman/nginx)
[![Build Status](https://travis-ci.org/miketheman/nginx.svg?branch=master)](https://travis-ci.org/miketheman/nginx)
[![Gitter chat](https://img.shields.io/badge/Gitter-miketheman%2Fnginx-brightgreen.svg)](https://gitter.im/miketheman/nginx)

**Note**: This branch is currently a Work-In-Progress, in hopes of rewriting the nginx cookbook
into a much better state.

A version 3.0.0 will be the target release, with better primitives, tests,
and an overall better interface.

---

What is this?
-------------
A cookbook to provide resources to install, configure and run [nginx][]
Open Source HTTP and reverse proxy server.

Requirements
------------
### Cookbooks
TBD

### Platforms
TBD

Usage
-----
TBD

Notes
-----
Inside providers, we dynamically render the resource name into the sub-resource
title to ensure uniqueness.
This avoids resource cloning via CHEF-3694 and allows ChefSpec to work properly.

License & Authors
-----------------
- Author:: Mike Fiedler (<miketheman@gmail.com>)

```text
Copyright 2015, Mike Fiedler

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

[nginx]: http://nginx.org/
