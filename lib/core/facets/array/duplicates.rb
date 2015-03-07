class Array

  # Return list of duplicate elements.
  #
  # min - The minimum number of duplication necessary for inclusion. [Integer]
  #
  # Examples:
  #
  #   [1,1,2,3].duplicates #=> [1]
  #
  #   [1,1,2,3,2,4,5,4,2].duplicates(3) #=> [2]
  #
  # CREDIT: Rebort Dober (current implementation)
  # CREDIT: Thibaut Barrère

  def duplicates(min=2)
    h = Hash.new( 0 )
    each {|i|
      h[i] += 1
    }
    h.delete_if{|_,v| v < min}.keys
  end

end
