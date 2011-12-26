class Array

  # Returns a list of non-unique elements
  #
  #   [1,1,2,2,3,4,5].nonuniq  #=> [1,2]
  #
  # @author Martin DeMello

  def nonuniq
    h1 = {}
    h2 = {}
    each {|i|
      h2[i] = true if h1[i]
      h1[i] = true
    }
    h2.keys
  end

  # Same as `#nonuniq` but acting in place.
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
  # @param [Integer] min
  #   The minimum number of duplicatation necessary for inclusion.
  #
  # @author Rebort Dober (current implementation)
  # @author Thibaut Barrère

  def duplicates(min=2)
    h = Hash.new( 0 )
    each {|i|
      h[i] += 1
    }
    h.delete_if{|_,v| v < min}.keys
  end

  # Returns a list of elements that occur +n+ times.
  #
  #  [0,1,1,1,3,0,1,2,4].occurent(3) #=> [1]
  #
  # If +n+ is a Range then returns elements that occur a number
  # of time within the range.
  #
  #  [0,1,1,1,3,0,1,2,4].occurent(2..4) #=> [0,1]
  #
  # @author Robert Dober

  def occurent(n=2)
    h = Hash.new( 0 )
    each do |i|
      h[i] += 1
    end

    case n
    when nil
      h.delete_if{ |_,v| ! yield(v) }.keys
    when Range
      h.delete_if{ |_,v| ! n.include?(v) }.keys
    else
      h.delete_if{|_,v| v != n}.keys
    end
  end

end

