require 'facets/integer/of'

Case Integer do

  Unit :of do
    a = 4
    b = a.of{ |i| i*2 }
    b.assert == [0,2,4,6]
  end

  Unit :times_collect do
    a = 4
    b = a.times_collect{ |i| i*2 }
    b.assert == [0,2,4,6]
  end

end

