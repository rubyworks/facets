covers 'facets/array/indexable'

tests Array do

  unit :first! => "alias of shift" do
    a = [1,2,3]
    r = a.first!
    r.assert == 1
    a.assert == [2,3]
  end

end

