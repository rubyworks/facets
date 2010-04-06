class Array

  # Returns a new array created by traversing the array and its
  # sub-arrays, executing the given block on the elements.
  #
  #   h = ["A", "B", ["X", "Y"]]
  #
  #   g = h.recursive_map{ |e| e.downcase }
  #
  #   g = ["a", "b", ["x", "y"]]
  #
  # CREDIT: Trans

  def recursive_map(&block)
    if block_given?
      map do |e|
        if e.respond_to?(:to_ary)
          e.to_ary.recursive_map(&block)
        else
          block.call(e)
        end
      end
    else
      to_enum(:recursive_map)
    end
  end

  # Like #recursive_map, but will change the
  # array in place.

  def recursive_map!(&block)
    replace(recusive_map(&block))
  end

end

