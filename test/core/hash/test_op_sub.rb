covers 'facets/hash/op_sub'

test_case Hash do

  method :- do

    test "hash minus array" do
      a = { :a => 1, :b => 2, :c => 3 }
      b = [ :a ]
      x = { :b => 2, :c => 3 }
      (a - b).assert == x
    end

  end

  method :- do

    test "hash minus hash" do
      a = { :a => 1, :b => 2, :c => 3 }
      b = { :a => 1, :d => 4 }
      x = { :b => 2, :c => 3 }
      (a - b).assert == x
    end

  end

end

