require 'facets/enumearble/squeeze'

class Array

  # Apply a block to array, and recursively apply that block
  # to each sub-array or +types+.
  #
  #   a = [1,2,2,3,3,2,1]
  #   a.squeeze!
  #   a #=> [1,2,3,2,1]
  #
  # Returns the receiver. [Array]
  #
  # CREDIT: T. Yamada

  def squeeze!
    replace(squeeze)
  end

end
