warn "Use BasicObject instead of BlankSlate for future versions."
require 'facets/basicobject'


unless defined? BlankSlate
  # ActiveSupport compatiable version of BasicObject
  # if not Ruby 1.9+ uses Jim Weirich's BlankSlate.
  BlankSlate = ::BasicObject
end

