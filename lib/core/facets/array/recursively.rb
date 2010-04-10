class Array

  # Apply a block to array, and recursively apply that block
  # to each subarray.
  #
  #   arr = ["a", ["b", "c", nil], nil]
  #   arr.recursively{|a| a.compact! }
  #   => ["a", ["b", "c"]]
  #
  def recursively(&block)
    warn "Use #recusive instead of #recursively for future versions"
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

