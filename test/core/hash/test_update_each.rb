covers 'facets/hash/update_each'

test_case Hash do

  method :update_each do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      x = { :a => 2, :b => 3, :c => 4 }
      a.update_each{ |k,v| { k => v+1 } }
      a.assert == x
    end

  end

end
