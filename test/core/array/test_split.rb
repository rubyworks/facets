covers 'facets/array/split'

test_case Array do

  method :split do

    test do
      ['a','b','c'].split('b').assert == [['a'], ['c']]
    end

    test "empty" do
      [].split('a').assert == []
    end

    test "same" do
      ['a'].split('a').assert == []
    end

  end

end

