Covers 'facets/hash/op_or'

Case Hash do

  Unit :| do
    a = { :a => 1, :b => 2 }
    b = { :b => 3 }
    x = { :a => 1, :b => 2 }
    (a | b).assert == x
  end

end

