module Enumerable

  # Uses #+ to sum the enumerated elements.
  #
  #     [1,2,3].sum      #=> 6
  #     [3,3,3].sum      #=> 9
  #
  # Note that Facets' sum method is completely generic -- it can work
  # on any objects that respond to #+.
  #
  #     [[1],[2],[3]].sum   #=> [1,2,3]
  #
  # For this reason it is usually a good idea to provide a default
  # value. Consider the difference between the two expressions below.
  #
  #     [].sum           #=> nil
  #     [].sum(0)        #=> 0
  #
  # This default value also acts as an initial value.
  #
  #     [].sum(5)        #=> 5
  #     [1,2,3].sum(10)  #=> 16
  #
  # A block can also be passed to coax the elements before summation.
  # 
  #     [1.1,2.2,3.3].sum(10.4, &:to_i)  #=> 16.4
  #
  # Notice the initial value is not effected by the block.
  #
  # @author Dawid Marcin Grzesiak

  def sum(*identity, &block)
    if block_given?
      map(&block).sum(*identity)
    else
      reduce(*identity) { |sum, element| sum + element }
    end
  end

end
