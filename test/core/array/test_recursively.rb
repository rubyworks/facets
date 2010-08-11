Covers 'facets/array/recursively'

TestCase Array do

  unit :recursively do
    a = ["a", ["b", "c", nil], nil]
    r = a.recursively{|a| a.compact! }
    r.assert ["a", ["b", "c"]]
  end

  unit :recursively! do
    a = ["a", ["b", "c", nil], nil]
    a.recursively!{|a| a.compact! }
    a.assert ["a", ["b", "c"]]
  end

end
