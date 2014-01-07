require 'facets/math/distance'

test_case Math do

  class_method :distance do
    test do
      Math.distance(1, 2).assert == 1.0
      Math.distance([1,2], [3,4]).assert >= 2.828427
      Math.distance([1,2], [3,4]).assert <= 2.8284271247461903
      Math.distance([1,2,3], [4,5,6]).assert >= 5.196152
      Math.distance([1,2,3], [4,5,6]).assert <= 5.196152422706632
      Math.distance([1,2,3,4], [5,6,7,8]).assert == 8.0
    end
  end

end
