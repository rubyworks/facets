require 'facets/array/product'

class Array
  # Array#** is an alias for Array#product.
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  alias_method :**, :product
end
