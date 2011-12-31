module Kernel

  # Hierarchically apply a block, passing each ancestor to the block
  # starting at the root ancestor and working toward the current object.
  #
  def hierarchically(&block)
    ancestors.reverse_each do |m|
      block.call(m)
    end
  end

end
