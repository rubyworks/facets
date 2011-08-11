covers 'facets/hash/op_or'

test_case Hash do

  method :| do

    test do
      a = { :a => 1, :b => 2 }
      b = { :b => 3 }
      x = { :a => 1, :b => 2 }
      (a | b).assert == x
    end

  end

end

