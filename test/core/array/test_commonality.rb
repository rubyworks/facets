covers 'facets/array/commonality'

test_case Array do

  method :commonality do

    test do
      a = [1,2,2,3,3,3]
      e = { 2 => [2,2], 3 => [3,3,3] }
      r = a.commonality
      r.assert == e
    end

    test "with block" do
      a = [1,2,2,3,3,3]
      e = {false=>[1, 2, 2], true=>[3, 3, 3]}
      r = a.commonality{ |x| x > 2 }
      r.assert == e
    end

  end

  method :collisions do

    test "alias for commonality" do
      a = [1,2,2,3,3,3]
      e = { 2 => [2,2], 3 => [3,3,3] }
      r = a.collisions
      r.assert == e
    end

  end

end

