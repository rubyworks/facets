class Array

  # Returns a new array created by traversing the array and its
  # sub-arrays, executing the given block on the elements.
  #
  #   h = ["A", "B", ["X", "Y"]]
  #
  #   g = h.traverse{ |e| e.downcase }
  #
  #   g  #=> ["a", "b", ["x", "y"]]
  #
  # This is the same as <code>recursive.map</code> and will
  # likely be deprecated in the future because of it.
  #
  # CREDIT: Trans
  def traverse(&block)
    if block_given?
      map do |e|
        if e.respond_to?(:to_ary)
          e.to_ary.traverse(&block)
        else
          block.call(e)
        end
      end
    else
      to_enum(:traverse)
    end
  end

  # Like #recursive_map, but will change the array in place.
  #
  #   h = ["A", "B", ["X", "Y"]]
  #
  #   h.traverse!{ |e| e.downcase }
  #
  #   h  #=> ["a", "b", ["x", "y"]]
  #
  # CREDIT: Trans
  def traverse!(&block)
    replace(traverse(&block))
  end

end

