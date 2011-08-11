covers 'facets/hash/alias'

test_case Hash do

  method :alias! do

    test do
      foo = { 'a'=>1, 'b'=>2 }
      foo.alias!('c','b').assert == { 'a'=>1, 'b'=>2, 'c'=>2 }
    end

    test do
      foo = { 'a'=>1, 'b'=>2 }
      foo.alias!(:a,'a').assert == { :a=>1, 'a'=>1, 'b'=>2 }
    end

    test do
      foo = { :a=>1, :b=>2 }
      foo.alias!('bar','foo').assert == { :a=>1, :b=>2 }
    end

  end

end

