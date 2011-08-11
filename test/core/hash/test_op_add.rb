covers 'facets/hash/op_add'

test_case Hash do

  method :+ do

    test do
      a = { :a => 1, :b => 2 }
      b = { :b => 3, :c => 4 }
      x = { :a => 1, :b => 3, :c => 4 }
      r = a + b
      r.assert == x
    end

  end

end
