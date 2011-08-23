# Require all NilClass core extensions.

if RUBY_VERSION < '1.9'
  require "facets/nilclass/ergo.rb"
  require "facets/nilclass/to_f.rb"
else
  require_relative "nilclass/ergo.rb"
  require_relative "nilclass/to_f.rb"
end

