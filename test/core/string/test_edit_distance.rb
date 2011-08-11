covers 'facets/string/edit_distance'

test_case String do

  method :edit_distance do

    test do
      d = "pretzel".edit_distance('pretzil')
      d.assert = 1
    end

    test do
      d = "zretzel".edit_distance('pretzil')
      d.assert = 2
    end

  end

end

