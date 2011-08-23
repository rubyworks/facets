# Require all ObjectSpace core extensions.

if RUBY_VERSION < '1.9'
  require "facets/objectspace/classes.rb"
  require "facets/objectspace/op_fetch.rb"
  require "facets/objectspace/reflect.rb"
else
  require_relative "objectspace/classes.rb"
  require_relative "objectspace/op_fetch.rb"
  require_relative "objectspace/reflect.rb"
end

