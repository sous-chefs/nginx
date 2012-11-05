# instead of using hard-coded path for passenger root, we should be using the following:
#%x{passenger-config --root}.chomp
#
node.default["nginx"]["passenger"]["version"] = "3.0.12"
node.default["nginx"]["passenger"]["root"] = "/usr/lib/ruby/gems/1.8/gems/passenger-3.0.12"
node.default["nginx"]["passenger"]["max_pool_size"] = 10

# the default value of this attribute is set in the recipe.  if set here using "which
# ruby" it results in failed chef runs on Windows just by being a dependency
node.default["nginx"]["passenger"]["ruby"] = nil