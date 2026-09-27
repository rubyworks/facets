covers 'facets/hash/symbolize_keys'

test_case Hash do

  method :symbolize_keys do

    test do
      foo = { 'a'=>1, 'b'=>2 }
      foo.symbolize_keys == { :a=>1, :b=>2 }
      foo.assert == { "a" =>1, "b"=>2 }
    end

  end

  method :symbolize_keys! do

    test do
      foo = { 'a'=>1, 'b'=>2 }
      foo.symbolize_keys!.assert == { :a=>1, :b=>2 }
      foo.assert == { :a=>1, :b=>2 }
    end

  end

end

