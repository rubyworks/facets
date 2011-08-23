# Require all MatchData core extensions.

if RUBY_VERSION < '1.9'
  require "facets/matchdata/match.rb"
  require "facets/matchdata/matchset.rb"
else
  require_relative "matchdata/match.rb"
  require_relative "matchdata/matchset.rb"
end

