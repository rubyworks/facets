module Enumerable

  # Uses #+ to sum the enumerated elements.
  #
  #     [1,2,3].sum      #=> 6
  #     [3,3,3].sum      #=> 9
  #     [].sum           #=> 0
  #
  # A initial value can be passed to the method.
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

  def sum(identity=0, &block)
    if block_given?
      map(&block).sum(identity)
    else
      reduce(identity) { |sum, element| sum + element }
    end
  end

end
