require 'facets/array/duplicates'

class Array

  # Returns a list of non-unique elements.
  #
  # Examples
  #
  #   [1,1,2,2,3,4,5].nonuniq  #=> [1,2]
  #
  # CREDIT: Martin DeMello

  def nonuniq
    warn "Array#nonuniq is deprecated. Use Array#duplicates instead.", uplevel: 1
    duplicates
  end

  # Same as `#nonuniq` but acts in place.

  def nonuniq!
    warn "Array#nonuniq! is deprecated. Use Array#duplicates instead.", uplevel: 1
    self.replace(duplicates)
  end

end

