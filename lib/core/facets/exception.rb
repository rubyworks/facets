# Load all Exception core extensions.

if RUBY_VERSION < '1.9'
  require "facets/exception/detail.rb"
  require "facets/exception/raised.rb"
  require "facets/exception/suppress.rb"
else
  require_relative "exception/detail.rb"
  require_relative "exception/raised.rb"
  require_relative "exception/suppress.rb"
end


