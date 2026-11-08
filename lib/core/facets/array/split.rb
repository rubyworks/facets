class Array

  # Split on matching elements. Unlike #divide this does not include the
  # matching elements. An element matches if `pattern === element`, so a
  # pattern can be a value, a Regexp or a class.
  #
  #   ['a1','a2','b1','a3','b2','a4'].split(/^b/)
  #   #=> [['a1','a2'],['a3'],['a4']]
  #
  # Or give a block, and split where it returns true.
  #
  #   [1, 2, 3, 4, 5].split { |x| x % 3 == 0 }
  #   #=> [[1, 2], [4, 5]]
  #
  # As with ActiveSupport's Array#split, every match ends a piece, so a match
  # at either end gives an empty piece there.
  #
  #   [2, 1, 2].split(2)  #=> [[], [1], []]
  #   [].split(2)         #=> [[]]
  #
  # Returns list of split-up arrays. [Array<Array>]

  def split(pattern=nil, &block)
    memo = []
    sect = []
    each do |obj|
      if block ? block.call(obj) : pattern === obj
        memo << sect
        sect = []
      else
        sect << obj
      end
    end
    memo << sect
  end

end
