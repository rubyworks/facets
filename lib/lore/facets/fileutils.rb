# = FileUtils Extensions
#
# General extensions for FileUtils.
#
# == Authors
#
# * Thomas Sawyer
# * Jim Weirich
# * Daniel Burger
#
# == Todo
#
# * Deprecate #safe_ln, if #ln has been fixed to do this.
#
# == Copying
#
#   Copyright (C) 2005 Thomas Saywer
#
#   Ruby License

require 'fileutils'
require 'facets/fileutils/safe_ln'
require 'facets/fileutils/slice'    # includes head and tail
require 'facets/fileutils/wc'
require 'facets/fileutils/whereis'
require 'facets/fileutils/which'

