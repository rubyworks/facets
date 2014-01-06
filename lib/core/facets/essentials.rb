# As suggested by Roger Pack this script is a simple convenience script
# for loading only the most *essential* of Facets core extensions.

# TODO: Work in progress. Please suggest which facets you think belong here.

require_relative 'functor'

#require 'binding/self'

require_relative 'kernel/true'
require_relative 'kernel/false'

require_relative 'file/write'
require_relative 'hash/rekey'
require_relative 'string/indent'

