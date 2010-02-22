module Enumerable

  # Yield each element to the block and return the result
  # of the block when that result evaluates as true,
  # terminating early like #detect and #find.
  # 
  #   obj1.foo? #=> false
  #   obj2.foo? #=> true
  #   obj2.foo  #=> "value"
  #
  #   [obj1, obj2].find_yield{ |obj| obj.foo if obj.foo? }     #=> "value"
  #
  # Another example:
  #
  #   [1,2,3,4,5].find_yield{ |i| j = i+1; j if j % 4 == 0 }   #=> "5"
  #
  # If the block is never true, return the object given in the first parameter,
  # or nil if none specified.
  #
  #   [1,2,3].find_yield{ |_| false }    #=> nil
  #   [false].find_yield(1){ |_| false } #=> 1
  #
  def find_yield(fallback=nil) #:yield:
    each do |member|
      result = yield(member)
      return result if result 
    end
    fallback
  end

  # DEPRECATE: This has been renamed to #find_yield.
  def map_detect(fallback=nil)
    find_yield(fallback)
  end

end

