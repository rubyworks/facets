require 'facets/enumerable/graph'

module Enumerable

  # @deprecated Use Enumerable#graph instead.
  #   Scheduled for removal after 2027-09-30.
  def mash(&yld)
    warn "Enumerable#mash is deprecated. Use Enumerable#graph instead. It will be removed after 2027-09-30.", uplevel: 1
    graph(&yld)
  end

end
