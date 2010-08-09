Covers 'facets/numeric/distance'

Case Numeric do

  Unit :distance do
    10.distance(6).assert == 4
    10.distance(8).assert == 2
     7.distance(9).assert == -2
  end

end

