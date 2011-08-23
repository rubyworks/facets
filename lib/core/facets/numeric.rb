# Require all Numeric core extensions.

if RUBY_VERSION < '1.9'
  require "facets/numeric/approx.rb"
  require "facets/numeric/distance.rb"
  require "facets/numeric/length.rb"
  require "facets/numeric/round.rb"
  require "facets/numeric/round_at.rb"
  require "facets/numeric/round_to.rb"
  require "facets/numeric/spacing.rb"
else
  require_relative "numeric/approx.rb"
  require_relative "numeric/distance.rb"
  require_relative "numeric/length.rb"
  require_relative "numeric/round.rb"
  require_relative "numeric/round_at.rb"
  require_relative "numeric/round_to.rb"
  require_relative "numeric/spacing.rb"
end

