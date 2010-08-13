covers 'facets/string/edit_distance'

tests String do

  unit :edit_distance do
    d = "pretzel".edit_distance('pretzil')
    d.assert = 1
  end

  unit :edit_distance do
    d = "zretzel".edit_distance('pretzil')
    d.assert = 2
  end

end

