covers 'facets/hash/delete_at'

test_case Hash do

  method :delete_at do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      x = { :b => 2, :c => 3 }
      v = a.delete_at(:a)
      v.assert == 1
      a.assert == x
    end

  end

end

