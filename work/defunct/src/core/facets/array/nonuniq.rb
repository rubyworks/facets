class Array

  # Returns a list of non-unique elements
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

  #
  def nonuniq!
    h1 = {}
    h2 = {}
    each {|i|
      h2[i] = true if h1[i]
      h1[i] = true
    }
    self.replace(h2.keys)
  end

  # Return list of duplictate elements.
  #
  # CREDIT: Thibaut Barrère

  alias_method :duplicates, :nonuniq

end

