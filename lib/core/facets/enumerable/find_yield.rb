module Enumerable

  # Yield each element to the block and return the result
  # of the block when that result evaluates as true,
  # terminating early like #detect and #find.
  # 
  #   obj1 = Object.new
  #   obj2 = Object.new
  #
  #   def obj1.foo?; false; end
  #   def obj2.foo?; true ; end
  #
  #   def obj1.foo ; "foo1"; end
  #   def obj2.foo ; "foo2"; end
  #
  #   [obj1, obj2].find_yield{ |obj| obj.foo if obj.foo? }  #=> "foo2"
  #
  # Another example.
  #
  #   [1,2,3,4,5].find_yield{ |i| j = i+1; j if j % 4 == 0 }  #=> 4
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

  # Alias for #find_yield.
  #
  # DEPRECATE: This has been renamed to #find_yield.
  alias_method :map_detect, :find_yield

end

