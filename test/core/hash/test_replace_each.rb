covers 'facets/hash/replace_each'

testcase Hash do

  unit :replace_each do
    a = { :a => 1, :b => 2, :c => 3 }
    x = { :a => 2, :b => 3, :c => 4 }
    a.replace_each{ |k,v| { k => v+1 } }
    a.assert == x
  end

end

