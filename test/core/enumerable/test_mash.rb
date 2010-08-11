covers 'facets/enumerable/mash'

tests Enumerable do

  unit :mash => "is an alias for #graph" do
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    r = a.mash{ |k,v| {k => v+1} }
    r.assert == e
  end

end

