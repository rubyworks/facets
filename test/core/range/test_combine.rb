covers 'facets/range/combine'

testcase Range do

  unit :combine do
    r = 0..4
    r = r.combine(2..6, 6..10, 13..17, 12..19)
    x = [0..10, 12..19]
    r.assert == x
  end

  meta :combine do
    r = Range.combine(0..4, 2..6, 6..10, 13..17, 12..19)
    x = [0..10, 12..19]
    r.assert == x
  end

  meta :combine => "arrays as intervals" do
    r = Range.combine([0, 4], [2, 6], [6, 10], [13, 17], [12, 19])
    x = [[0, 10], [12, 19]]
    r.assert == x
  end

end
