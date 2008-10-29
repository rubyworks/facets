# Facets' old BasicObject has been replaced totally replaced by 
# Jim Weirich's BlankSlate. Since Ruby 1.9 has a BasicObject class
# this  will of course be deprecated when 1.9 goes mainstream.

unless defined? ::BasicObject  # just in case it already exists!

  require 'facets/blankslate'

  # ActiveSupport compatiable version of BasicObject
  # if not Ruby 1.9+ uses Jim Weirich's BlankSlate.
  BasicObject = BlankSlate

end

