covers 'facets/hash/replace_each'

test_case Hash do

  method :replace_each do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      x = { :a => 2, :b => 3, :c => 4 }
      a.replace_each{ |k,v| { k => v+1 } }
      a.assert == x
    end

  end

end

