covers 'facets/hash/op_and'

testcase Hash do

  unit :& => "hash and hash" do
    a = { :a => 1, :b => 2 }
    b = { :a => 1 }
    x = { :a => 1 }
    (a & b).assert == x 
  end

  unit :& => "hashes with sub-array" do
    a = { :a => [1], :b => [2] }
    b = { :a => [1] }
    x = { :a => [1] }
    (a & b).assert == x
  end

  unit :& => "hash and array" do
    a = { :a => 1, :b => 2 }
    b = [ :a ]
    x = { :a => 1 }
    (a & b).assert == x
  end

end

