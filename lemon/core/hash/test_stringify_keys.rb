Covers 'facets/hash/stringify_keys'

Case Hash do

  Unit :stringify_keys do
    foo = { :a=>1, :b=>2 }
    foo.stringify_keys.assert == { "a"=>1, "b"=>2 }
    foo.assert == { :a =>1, :b=>2 }
  end

  Unit :stringify_keys! do
    foo = { :a=>1, :b=>2 }
    foo.stringify_keys!.assert == { "a"=>1, "b"=>2 }
    foo.assert == { "a"=>1, "b"=>2 }
  end

end

