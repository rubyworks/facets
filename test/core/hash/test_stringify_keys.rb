covers 'facets/hash/stringify_keys'

testcase Hash do

  unit :stringify_keys do
    foo = { :a=>1, :b=>2 }
    foo.stringify_keys.assert == { "a"=>1, "b"=>2 }
    foo.assert == { :a =>1, :b=>2 }
  end

  unit :stringify_keys! do
    foo = { :a=>1, :b=>2 }
    foo.stringify_keys!.assert == { "a"=>1, "b"=>2 }
    foo.assert == { "a"=>1, "b"=>2 }
  end

end

