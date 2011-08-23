# Load all Float core extensions.

if RUBY_VERSION < '1.9'
  require "facets/float/round.rb"
else
  require_relative "float/round.rb"
end

