nginx_test Cookbook
===================
A test fixture cookbook for importing some test SQL files into a test-kitchen VM

Using the [test fixture cookbook pattern](https://gist.github.com/nathwill/8827641).

What? Surprised to see a cookbook within a cookbook you say? Don't tell me you haven't seen [Inception](http://www.imdb.com/title/tt1375666/)!

Requirements
------------


#### cookbooks
- `nginx` - nginx_test needs nginx to test it.

Usage
-----
#### nginx_test::lwrps
Just include `nginx_test::lwrps` in your test-kitchen suite's `run_list`:

```yaml
suites:
  - name: nginx_site
    run_list:
      - recipe[nginx::default]
      - recipe[nginx:lwrps]
```

License and Authors
-------------------
Authors: James Cuzella
