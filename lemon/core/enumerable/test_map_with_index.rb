Covers 'facets/enumerable/map_with_index'

Case Enumerable do

  Unit :collect_with_index do
    a = [1,2,3].collect_with_index{ |e,i| e*i }
    a.assert == [0,2,6]
  end

end
