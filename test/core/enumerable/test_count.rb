covers 'facets/enumerable/count'

test_case Enumerable do

  method :count do

    test "strings" do
      e = ['a','1','a']
      r = e.count('1')
      r.assert == 1

      e = ['a','1','a']
      r = e.count('a')
      r.assert == 2
    end

    test "array of arrays" do
      e = [['a',2],['a',2],['a',2],['b',1]]
      r = e.count(['a',2])
      r.assert == 3
    end

    test "hash" do
      e = { :a=>2, 'b'=>1, :c=>2 }
      r = e.count(2)
      r.assert == 2
    end

  end

end

