covers 'facets/enumerable/graph'

test_case Enumerable do

  method :graph do

    test "returns hash" do
      a = { :a => 1, :b => 2, :c => 3 }
      e = { :a => 2, :b => 3, :c => 4 }
      r = a.graph{ |k,v| {k => v+1} }
      r.assert == e
    end

    test "hash of array" do
      a = { :a => [1,2], :b => [2,3], :c => [3,4] }
      e = { :a => 2, :b => 6, :c => 12 }
      r = a.graph{ |k,v| [k, v[0]*v[1] ] }
      r.assert == e
    end

    test "array of array" do
      a = [ [1,2], [2,3], [3,4] ]
      e = { [1,2] => 2, [2,3] => 6, [3,4] => 12 }
      r = a.graph{ |a| [a, a[0]*a[1] ] }
      r.assert == e
    end

    test "squares" do
      numbers  = (1..3)
      squares  = numbers.graph{ |n| [n, n*n] }
      squares.assert == {1=>1, 2=>4, 3=>9}
    end

    test "roots" do
      numbers  = (1..3)
      sq_roots = numbers.graph{ |n| [n*n, n] }
      sq_roots.assert == {1=>1, 4=>2, 9=>3}
    end

  end

end
