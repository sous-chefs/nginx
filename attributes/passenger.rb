# instead of using hard-coded path for passenger root, we should be using the following:
#%x{passenger-config --root}.chomp
#
node.default["nginx"]["passenger"]["version"] = "3.0.12"
node.default["nginx"]["passenger"]["root"] = "/usr/lib/ruby/gems/1.8/gems/passenger-3.0.12"
node.default["nginx"]["passenger"]["ruby"] = %x{which ruby}.chomp
node.default["nginx"]["passenger"]["max_pool_size"] = 10
