require 'facets/enumerable/mash'

class Hash

  # In place version of #graph.
  #
  # NOTE: Hash#graph! is only useful for Hash.
  # It is not generally applicable to Enumerable.

  def graph!(&yld)
    replace(graph(&yld))
  end

  # Alias for #graph! as an alliteration for "map hash".
  alias_method :mash!, :graph!

end

