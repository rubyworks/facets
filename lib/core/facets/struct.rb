# Require all Struct core extensions.

if RUBY_VERSION < '1.9'
  require "facets/struct/attributes.rb"
else
  require_relative "struct/attributes.rb"
end

