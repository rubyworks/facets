Covers 'facets/hash/symbolize_keys'

Case Hash do

  Unit :symbolize_keys do
    foo = { 'a'=>1, 'b'=>2 }
    foo.symbolize_keys == { :a=>1, :b=>2 }
    foo.assert == { "a" =>1, "b"=>2 }
  end

  Unit :symbolize_keys! do
    foo = { 'a'=>1, 'b'=>2 }
    foo.symbolize_keys!.assert == { :a=>1, :b=>2 }
    foo.assert == { :a=>1, :b=>2 }
  end

end

