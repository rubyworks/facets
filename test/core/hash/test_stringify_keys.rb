covers 'facets/hash/stringify_keys'

test_case Hash do

  method :stringify_keys do

    test do
      foo = { :a=>1, :b=>2 }
      foo.stringify_keys.assert == { "a"=>1, "b"=>2 }
      foo.assert == { :a =>1, :b=>2 }
    end

  end

  method :stringify_keys! do

    test do
      foo = { :a=>1, :b=>2 }
      foo.stringify_keys!.assert == { "a"=>1, "b"=>2 }
      foo.assert == { "a"=>1, "b"=>2 }
    end

  end

end

