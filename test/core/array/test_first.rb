covers 'facets/array/indexable'

test_case Array do

  method :first! do 

    test "alias of shift" do
      a = [1,2,3]
      r = a.first!
      r.assert == 1
      a.assert == [2,3]
    end

  end

end

