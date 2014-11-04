require 'facets/math/pow'
require 'facets/numeric/range'

test_case Math do

  class_method :pow do
    test do
      Math.pow(  4.0,   3.0).range(1.0e-6).assert === 64.0  
      Math.pow(  0.9,   3.0).range(1.0e-6).assert === 0.729
      Math.pow(  0.25, -0.5).range(1.0e-6).assert === 2.0   
      Math.pow( 64.0,  -1.0/3).range(1.0e-6).assert === 0.25
    end
  end

  class_method :pwr do
    test do
      Math.pwr(  4.0,   3.0).range(1.0e-6).assert === 64.0  
      Math.pwr(  0.9,   3.0).range(1.0e-6).assert === 0.729
      Math.pwr(  0.25, -0.5).range(1.0e-6).assert === 2.0   
      Math.pwr( 64.0,  -1.0/3).range(1.0e-6).assert === 0.25
    end
  end

  # TODO: Check complementarity of pwr and root
  #  assert_equal_float(           4.0, Math.root(Math.pwr(2.0, 6.0), 3.0), 1.0e-6)
  #  assert_equal_float(           2.0, Math.root(Math.pwr(4.0, 4.0), 8.0), 1.0e-6)
  #  assert_equal_float(Math.sqrt(2.0), Math.pwr(Math.root(2.0, 6.0), 3.0), 1.0e-6)
  #  assert_equal_float(          16.0, Math.pwr(Math.root(4.0, 4.0), 8.0), 1.0e-6)

end
