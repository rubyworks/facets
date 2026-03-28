require 'facets/enumerable/graph'

module Enumerable

  # @deprecated Use Enumerable#graph instead.
  def mash(&yld)
    warn "Enumerable#mash is deprecated. Use Enumerable#graph instead.", uplevel: 1
    graph(&yld)
  end

end
