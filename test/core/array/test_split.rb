covers 'facets/array/split'

test_case Array do

  method :split do

    test do
      ['a','b','c'].split('b').assert == [['a'], ['c']]
    end

    test "empty" do
      [].split('a').assert == [[]]
    end

    test "same" do
      ['a'].split('a').assert == [[], []]
    end

    test "keeps empty pieces at both ends, as ActiveSupport does" do
      [2, 1, 2].split(2).assert == [[], [1], []]
    end

    test "matches with ===" do
      ['a1','a2','b1','a3','b2','a4'].split(/^b/).assert == [['a1','a2'],['a3'],['a4']]
    end

    test "splits on nil by default" do
      [1, nil, 2].split.assert == [[1], [2]]
    end

    test "splits where a block returns true" do
      [1, 2, 3, 4, 5].split { |x| x % 3 == 0 }.assert == [[1, 2], [4, 5]]
    end

  end

end

