require 'facets/array/recursive_map'

class Array
  alias_method :traverse,  :recursive_map
  alias_method :traverse!, :recursive_map!
end

