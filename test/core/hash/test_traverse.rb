covers 'facets/hash/traverse'

testcase Hash do

  unit :traverse do
    h = { "A" => "x", "B" => "y" }
    j = h.traverse{ |k,v| [k.downcase, v.upcase] }
    x = { "a" => "X", "b" => "Y" }
    j.refute == h
    j.assert == x
  end

  unit :traverse! do
    h = { "A" => "x", "B" => "y" }
    h.traverse!{ |k,v| [k.downcase, v.upcase] }
    x = { "a" => "X", "b" => "Y" }
    h.assert == x
  end

end

