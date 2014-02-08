require 'facets/enumearble/squeeze'

class Array

  # Destructive version of Enumerable#squeeze.
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
