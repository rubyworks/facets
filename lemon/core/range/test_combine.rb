require 'facets/range/combine'

Case Range do

  Unit :combine do
    r = Range.combine(0..4, 2..6, 6..10, 13..17, 12..19)
    x = [0..10, 12..19]
    r.assert == x
  end

  Unit :combine => "arrays as intervals" do
    r = Range.combine([0, 4], [2, 6], [6, 10], [13, 17], [12, 19])
    x = [[0, 10], [12, 19]]
    r.assert == x
  end

end
