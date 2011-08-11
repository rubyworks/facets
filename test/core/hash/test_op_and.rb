covers 'facets/hash/op_and'

test_case Hash do

  method :& do

    test "hash and hash" do
      a = { :a => 1, :b => 2 }
      b = { :a => 1 }
      x = { :a => 1 }
      (a & b).assert == x 
    end

    test "hashes with sub-array" do
      a = { :a => [1], :b => [2] }
      b = { :a => [1] }
      x = { :a => [1] }
      (a & b).assert == x
    end

    test "hash and array" do
      a = { :a => 1, :b => 2 }
      b = [ :a ]
      x = { :a => 1 }
      (a & b).assert == x
    end

  end

end

