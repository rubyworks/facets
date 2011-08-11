covers 'facets/array/recursively'

test_case Array do

  method :recursively do

    test "each" do
      r = []
      [1,2,['a','b']].recursively{ |v| v }.each{ |v| r << v }
      r.assert == [1,2,'a','b']
    end

    test "map" do
      a = [1,2,['a','b']]
      r = a.recursively{ |v| v.reverse }.map{ |v| v.succ }
      r.assert == [2,3,['c','b']]
    end

    test "map!" do
      a = [1,2,['a','b']]
      a.recursively{ |v| v }.map!{ |v| v.succ }
      a.assert == [2,3,['b','c']]
    end

    test "with block" do
      a = [1,2,['a','b', nil], nil]
      r = a.recursively{ |v| v.compact }.map{ |v| v }.compact
      r.assert == [1,2,['a','b']]
    end

  end

end
