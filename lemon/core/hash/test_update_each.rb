Covers 'facets/hash/update_each'

Case Hash do

  Unit :update_each do
    a = { :a => 1, :b => 2, :c => 3 }
    x = { :a => 2, :b => 3, :c => 4 }
    a.update_each{ |k,v| { k => v+1 } }
    a.assert == x
  end

end
