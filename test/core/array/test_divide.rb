covers 'facets/array/divide'

testcase Array do

  unit :divide do
    r = ['a1','b1','a2','b2'].divide(/^a/)
    r.assert == [['a1','b1'],['a2','b2']]
  end

end
