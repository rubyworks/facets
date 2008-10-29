class Array

  # Apply a block to hash, and recursively apply that block
  # to each subhash.
  #
  #   arr = ["a", ["b", "c", nil], nil]
  #   arr.recursively{|a| a.compact! }
  #   => ["a", ["b", "c"]]
  #
  # TODO: Can this be generalized in Enumerbale?

  def recursively(&block)
    a = inject([]) do |array, value|
      if value.is_a?(Array)
        array << value.recursively(&block)
      else
        array << value
      end
      array
    end
    yield a
  end

  # In place form of #recursively.

  def recursively!(&block)
    replace(recursively(&block))
  end

end
