# Require all Range core extensions.

if RUBY_VERSION < '1.9'
  require "facets/range/combine.rb"
  require "facets/range/overlap.rb"
  require "facets/range/to_r.rb"
  require "facets/range/umbrella.rb"
  require "facets/range/within.rb"
else
  require_relative "range/combine.rb"
  require_relative "range/overlap.rb"
  require_relative "range/to_r.rb"
  require_relative "range/umbrella.rb"
  require_relative "range/within.rb"
end

