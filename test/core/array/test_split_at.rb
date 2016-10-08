covers 'facets/array/split_at'

test_case Array do

  method :split_at do

    test do
      ['a','b','c'].split_at('b').assert == [['a'], 'b', ['c']]
    end

    test "empty" do
      [].split_at('a').assert == [[], nil, []]
    end

    test "same" do
      ['a'].split_at('a').assert == [[], 'a', []]
    end

    test "block" do
      ['a','b','c'].split_at{|e| e == 'b'}.assert == [['a'], 'b', ['c']]
    end

  end

end

