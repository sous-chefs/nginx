source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'test', path: 'test/cookbooks/test'
  cookbook 'freebsd'
  cookbook 'yum' # needed for the dnf compat recipe until Chef supports dnf
end
