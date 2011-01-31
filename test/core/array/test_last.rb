covers 'facets/array/indexable'

tests Array do

  unit :last! => "alias of pop" do
    a = [1,2,3]
    r = a.last!
    r.assert == 3
    a.assert == [1,2]
  end

end

