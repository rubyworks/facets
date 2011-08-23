class Array

  # Apply a block to array, and recursively apply that block
  # to each sub-array or +types+.
  #
  #   arr = ["a", ["b", "c", nil], nil]
  #   arr.recurse{ |a| a.compact! }
  #   #=> ["a", ["b", "c"]]
  #
  def recurse(*types, &block)
    types = [self.class] if types.empty?
    a = inject([]) do |array, value|
      case value
      when *types
        array << value.recurse(*types, &block)
      else
        array << value
      end
      array
    end
    yield a
  end

  # In place form of #recurse.
  def recurse!(&block)
    replace(recurse(&block))
  end

end
