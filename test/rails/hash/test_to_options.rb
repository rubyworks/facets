covers 'facets/hash/to_options'

test_case Hash do

  method :to_options do

    test do
      foo = { 'a'=>1, 'b'=>2 }
      foo.to_options.assert == { :a=>1, :b=>2 }
      foo.assert == { 'a'=>1, 'b'=>2 }
    end

  end

  method :to_options! do

    test do
      foo = { 'a'=>1, 'b'=>2 }
      foo.to_options!
      foo.assert == { :a=>1, :b=>2 }
    end

  end

end
