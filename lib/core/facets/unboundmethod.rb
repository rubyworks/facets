# Require all UnboundMethod core extensions.

if RUBY_VERSION < '1.9'
  require "facets/unboundmethod/arguments.rb"
  require "facets/unboundmethod/name.rb"
else
  require_relative "unboundmethod/arguments.rb"
  require_relative "unboundmethod/name.rb"
end

