require 'facets/comparable/bound'

TestCase Comparable do

  unit :at_most do
    3.at_most(4).assert == 3
    4.at_most(4).assert == 4
    5.at_most(4).assert == 4
  end

  unit :at_least do
    3.at_least(4).assert == 4
    4.at_least(4).assert == 4
    5.at_least(4).assert == 5
  end

  unit :cap do
    3.cap(4).assert == 3
    4.cap(4).assert == 4
    5.cap(4).assert == 4
  end

end

