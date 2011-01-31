covers 'facets/array/commonality'

tests Array do

  unit :commonality do
    a = [1,2,2,3,3,3]
    e = { 2 => [2,2], 3 => [3,3,3] }
    r = a.commonality
    r.assert == e
  end

  unit :commonality => "with block" do
    a = [1,2,2,3,3,3]
    e = {false=>[1, 2, 2], true=>[3, 3, 3]}
    r = a.commonality{ |x| x > 2 }
    r.assert == e
  end

  unit :collisions => "alias for commonality" do
    a = [1,2,2,3,3,3]
    e = { 2 => [2,2], 3 => [3,3,3] }
    r = a.collisions
    r.assert == e
  end

end

