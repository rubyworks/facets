module Enumerable

  # Yield each element to the block.  Returns the result of
  # the block when the block is true, terminating early as detect does.
  # 
  #   obj1.foo? #=> false
  #   obj2.foo? #=> true
  #
  #   obj2.foo  #=> "a value"
  #
  #   [obj1, obj2].map_detect { |obj| obj.foo if obj.foo? } #=> "a value"
  #
  # If the block is never true, return the object given in the first parameter,
  # or nil if none specified.
  #
  #   [1,2,3].map_detect { |_| false }    #=> nil
  #   [false].map_detect(1) { |_| false } #=> 1
  #
  def map_detect(value_for_none_matching = nil)
    each do |member|
      if result = yield(member)
        return result
      end
    end
    
    value_for_none_matching
  end
end
