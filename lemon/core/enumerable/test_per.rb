require 'facets/enumerable/per'

Case Enumerable do

  Unit :per => "map" do
    e = [1,2,3].per.map

    (e + 3).assert == [4,5,6]
    (e - 1).assert == [0,1,2]

    e.to_s.assert == ['1','2','3']
  end

end

