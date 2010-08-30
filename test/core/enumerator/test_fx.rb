covers 'facets/enumerator/fx'

testcase Enumerator do

  unit :fx do
    e = [1,2,3].to_enum
    r = e.fx + 2
    r.assert == [3,4,5]
  end

end

