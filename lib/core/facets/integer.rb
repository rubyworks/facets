# Load all Integer core extensions.

if RUBY_VERSION < '1.9'
  require "facets/integer/bit.rb"
  require "facets/integer/bitmask.rb"
  require "facets/integer/even.rb"
  require "facets/integer/factorial.rb"
  require "facets/integer/multiple.rb"
  require "facets/integer/odd.rb"
  require "facets/integer/of.rb"
  require "facets/integer/ordinal.rb"
else
  require_relative "integer/bit.rb"
  require_relative "integer/bitmask.rb"
  require_relative "integer/even.rb"
  require_relative "integer/factorial.rb"
  require_relative "integer/multiple.rb"
  require_relative "integer/odd.rb"
  require_relative "integer/of.rb"
  require_relative "integer/ordinal.rb"
end

