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
  def hinge(init={}, &block)
    warn "Enumerable#hinge is deprecated. Use Enumerable#each_with_object instead (note: block args are reversed).", uplevel: 1
    each_with_object(init) { |e, obj| block.call(obj, e) }
  end

end
