Covers 'facets/hash/zipnew'

Case Hash do

  Unit :zipnew do
    a = [1,2,3]
    b = [4,5,6]
    Hash.zipnew(a,b).assert == {1=>4,2=>5,3=>6}
  end

end

