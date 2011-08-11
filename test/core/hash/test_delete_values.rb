covers 'facets/hash/delete_values'

test_case Hash do

  method :delete_values do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      x = { :b => 2, :c => 3 }
      r = a.delete_values(1)
      #r.assert == x
      a.assert == x
    end

  end

  method :delete_values_at do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      x = { :b => 2, :c => 3 }
      r = a.delete_values_at(:a)
      r.assert == [1]
      a.assert == x
    end

  end

end

