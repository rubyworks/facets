covers 'facets/array/indexable'

test_case Array do

  method :last! do

    test "alias of pop" do
      a = [1,2,3]
      r = a.last!
      r.assert == 3
      a.assert == [1,2]
    end

  end

end

