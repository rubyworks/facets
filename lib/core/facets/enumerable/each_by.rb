require 'enumerator'

module Enumerable

  # Iterate through slices. If slice +steps+ is not
  # given, the arity of the block is used.
  #
  #   x = []
  #   [1,2,3,4].each_by{ |a,b| x << [a,b] }
  #   x  #=> [ [1,2], [3,4] ]
  #
  #   x = []
  #   [1,2,3,4,5,6].each_by(3){ |a| x << a }
  #   x  #=> [ [1,2,3], [4,5,6] ]
  #
  # This is just like each_slice, except that it will check
  # the arity of the block. If each_slice ever suppots this
  # this method can be deprecated.
  #
  #  CREDIT: Trans

  def each_by(steps=nil, &block)
    if steps
      each_slice(steps, &block)
    else
      steps = block.arity.abs
      each_slice(steps, &block)
      #each_slice(steps) {|i| block.call(*i)}
    end
  end

end

