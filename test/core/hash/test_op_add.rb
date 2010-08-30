covers 'facets/hash/op_add'

testcase Hash do

  unit :+ do
    a = { :a => 1, :b => 2 }
    b = { :b => 3, :c => 4 }
    x = { :a => 1, :b => 3, :c => 4 }
    (a + b).assert == x
  end

end

