class Array
  # Array#** is an alias for Array#product.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/array/op_pow'
  #
  alias_method :**, :product
end

