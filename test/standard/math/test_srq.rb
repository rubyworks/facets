require 'facets/math/sqr'
require 'facets/numeric/range'

test_case Math do

  class_method :sqr do
    test do
      Math.sqr(-0.9).range(1.0e-6).assert === 0.81
      Math.sqr(-0.7).range(1.0e-6).assert === 0.49
      Math.sqr(-0.7).range(1.0e-6).assert === 0.49
      Math.sqr( 0.9).range(1.0e-6).assert === 0.81
    end
  end

  # TODO: Check complementarity of sqrt and sqr
  #  assert_equal_float(0.3, Math.sqrt(Math.sqr( 0.3)), 1.0e-6)
  #  assert_equal_float(0.3, Math.sqrt(Math.sqr(-0.3)), 1.0e-6)
  #  assert_equal_float(0.3, Math.sqr(Math.sqrt( 0.3)), 1.0e-6)

end
