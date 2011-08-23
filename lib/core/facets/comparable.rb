# Load all Comparable core extensions.

if RUBY_VERSION < '1.9'
  require "facets/comparable/at_least.rb"
  require "facets/comparable/at_most.rb"
  require "facets/comparable/bound.rb"
  require "facets/comparable/cap.rb"
  require "facets/comparable/clip.rb"
  require "facets/comparable/cmp.rb"
  require "facets/comparable/op_get.rb"
else
  require_relative "comparable/at_least.rb"
  require_relative "comparable/at_most.rb"
  require_relative "comparable/bound.rb"
  require_relative "comparable/cap.rb"
  require_relative "comparable/clip.rb"
  require_relative "comparable/cmp.rb"
  require_relative "comparable/op_get.rb"
end

