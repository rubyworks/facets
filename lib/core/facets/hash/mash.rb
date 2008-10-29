require 'facets/enumerable/mash'

class Hash

  # In place version of #mash.
  #
  #   NOTE: Hash#mash! is only useful for Hash. It is not generally
  #         applicable to Enumerable.

  def mash!(&yld)
    replace(mash(&yld))
  end

  # Alias for #mash!. This is the original name for this method.
  alias_method :graph!, :mash!

end

