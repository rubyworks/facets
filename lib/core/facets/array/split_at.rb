class Array

  # Split on matching pattern. Breaks the array into [before, middle, after]
  # segments. Uses Array#index to find the middle element.
  #
  # Examples
  #
  #   ['a1','a2','b1','a3','b2','a4'].split('b1')
  #   #=> [['a1','a2'],b1,['a3','b2','a4']]
  #
  #   ['a1','a2','b1','a3','b2','a4'].split('foo')
  #   #=> [[],nil,[]]
  #
  # Returns list of split-up arrays. [Tuple<Array,Object,Array>]

  def split_at(*args, &block)
    if middle = index(*args, &block)
      [self[0...middle], self[middle], self[middle+1..-1]]
    else
      [[], nil, []]
    end
  end

end

