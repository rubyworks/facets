# Facets' extensions to Ruby's OpenStruct.
#
# NOTE: `ostruct` is deprecated as of Ruby 3.4, and as of Ruby 4.0 it is a
# bundled gem rather than a default gem. Ruby still installs it, but a Bundler
# project must list `ostruct` in its Gemfile or gemspec to load it. The gem
# itself still exists, so these extensions continue to work on top of it.
#
# Given OpenStruct's deprecation, Facets may divest these extensions in a
# future release.

require 'ostruct'
require 'facets/ostruct/initialize'
require 'facets/ostruct/to_ostruct'
