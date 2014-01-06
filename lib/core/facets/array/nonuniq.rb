class Array

  # Returns a list of non-unique elements.
  #
  # Examples
  #
  #   [1,1,2,2,3,4,5].nonuniq  #=> [1,2]
  #
  # CREDIT: Martin DeMello

  def nonuniq
    h1 = {}
    h2 = {}
    each {|i|
      h2[i] = true if h1[i]
      h1[i] = true
    }
    h2.keys
  end

  # Same as `#nonuniq` but acts in place.

  def nonuniq!
    self.replace(self.nonuniq)
  end

end

