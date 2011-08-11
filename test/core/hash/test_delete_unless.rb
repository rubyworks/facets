covers 'facets/hash/delete_unless'

test_case Hash do

  method :delete_unless do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      x = { :a => 1 }
      r = a.delete_unless{|k,v| v == 1}
      r.assert == x
      a.assert == x
    end

  end

end

