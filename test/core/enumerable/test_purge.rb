covers 'facets/enumerable/purge'

test_case Enumerable do

  method :purge do

    test do
      [1, nil, 2].purge.assert == [1,2]
    end

    test "with trash arguments" do
      (1..6).purge(3,4).assert == [1,2,5,6]
    end

    test "with block" do
      (1..6).purge(0){ |n| n % 2 }.assert == [1,3,5]
      (1..6).purge(1){ |n| n % 2 }.assert == [2,4,6]
    end

  end

end
