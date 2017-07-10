covers 'facets/array/span'

test_case Array do
  method :span do
    test 'Empty array returns a tuple of empty arrays' do
      [].span { true }.assert == [[], []]
    end

    test 'Constant true block returns the entire array as the prefix' do
      %w(foo bar baz quux).span { true }.assert == [%w(foo bar baz quux), []]
    end

    test 'Finds longest prefix that satisfies predicate' do
      predicate = ->(e) { e.even? }
      [2, 4, 11, 4, 8].span(&predicate).assert [[2, 4], [11, 4, 8]]
    end
  end
end
