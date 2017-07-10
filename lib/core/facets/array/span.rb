class Array
  # Public: Split an array in two using a predicate
  #
  # Yields each element of the array.
  #
  # Examples
  #
  #   %w(The quick brown fox).span { |word| word.length < 4 }
  #   #=> [['The'], ['quick', 'brown', 'fox']]
  #
  #   [1, 1, 2, 3, 5, 8, 13, 21, 34].span(&:odd?)
  #   #=> [[1, 1], [2, 3, 5, 8, 13, 21, 34]]
  #
  # Returns a 2-tuple of arrays, the first element being the longest prefix for
  # which the block evaluates to true, the second element being the rest of the
  # array.
  def span
    # This implementation is another way of saying
    # `[take_while(&:block), drop_while(&:block)]`
    index = find_index { |e| !yield e }
    return [dup, []] if index.nil?
    [take(index), drop(index)]
  end
end
