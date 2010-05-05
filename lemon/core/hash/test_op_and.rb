Covers 'facets/hash/op_and'

Case Hash do

  Unit :& => "hash and hash" do
    a = { :a => 1, :b => 2 }
    b = { :a => 1 }
    x = { :a => 1 }
    (a & b).assert == x 
  end

  Unit :& => "hashes with sub-array" do
    a = { :a => [1], :b => [2] }
    b = { :a => [1] }
    x = { :a => [1] }
    (a & b).assert == x
  end

  Unit :& => "hash and array" do
    a = { :a => 1, :b => 2 }
    b = [ :a ]
    x = { :a => 1 }
    (a & b).assert == x
  end

end

