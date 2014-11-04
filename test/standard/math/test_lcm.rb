require 'facets/math/lcm'

test_case Math do

  class_method :lcm do
    test do
      Math.lcm( 77, 221).assert == 17017
      Math.lcm(143, 187).assert == 2431
      Math.lcm( 91, 119).assert == 1547
    end
  end

end
