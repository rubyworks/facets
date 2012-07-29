module Enumerable

  # Apply each element of an enumerable ot a hash
  # by iterating over each element and yielding
  # the hash and element.
  #
  #   [1,2,3].hinge{|h,e| h[e] = e+1 }
  #   #=> {1=>2, 2=>3, 3=>4}
  #
  # TODO: Enumerable#hinge will get a new name.
  #
  def hinge(init={})
    h = init
    each{ |v| yield(h,v) }
    h
  end

end
