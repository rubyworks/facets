require 'facets/hash/recursive_graph'

class Hash

  alias_method :traverse,  :recursive_graph
  alias_method :traverse!, :recursive_graph!

end

