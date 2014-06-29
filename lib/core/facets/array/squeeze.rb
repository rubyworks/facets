require 'facets/enumerable/squeeze'

class Array

  # Destructive version of Enumerable#squeeze.
  #
  #   a = [1,2,2,3,3,2,1]
  #   a.squeeze!
  #   a #=> [1,2,3,2,1]
  #
  #   a = [1,2,2,3,3,2,1]
  #   a.squeeze!(*[3])
  #   a #=> [1,2,2,3,2,1]
  #
  # Returns the receiver. [Array]
  #
  # CREDIT: T. Yamada

  def squeeze!(*limited_to)
    replace(squeeze(*limited_to))
  end

end
