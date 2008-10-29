# This simply adds core/facets to the load path so
# that you can more easily cherry pick methods,
# if that's how you prefer to use facets.
#
# Ex.
#
#   require 'facets-load'
#   require 'kernel/with'
#   require 'symbol/to_proc'
#
$LOAD_PATH << FILE.dirname(__FILE__) + '/core/facets'

