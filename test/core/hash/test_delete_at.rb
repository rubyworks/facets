covers 'facets/hash/delete_at'

tests Hash do

  unit :delete_at do
    a = { :a => 1, :b => 2, :c => 3 }
    x = { :b => 2, :c => 3 }
    v = a.delete_at(:a)
    v.assert == 1
    a.assert == x
  end

end

