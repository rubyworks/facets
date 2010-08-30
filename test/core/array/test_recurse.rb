covers 'facets/array/recurse'

testcase Array do

  unit :recurse do
    a = ["a", ["b", "c", nil], nil]
    r = a.recurse{|a| a.compact! }
    r.assert ["a", ["b", "c"]]
  end

  unit :recurse! do
    a = ["a", ["b", "c", nil], nil]
    a.recurse!{|a| a.compact! }
    a.assert ["a", ["b", "c"]]
  end

end
