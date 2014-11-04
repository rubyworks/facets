require 'facets/math/acot'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :acot do
    test do
      Math.acot(-1.0).range(1.0e-6).assert === 0.5 * Math::PI - Math.atan(-1.0)
      Math.acot( 1.0).range(1.0e-6).assert === 0.5 * Math::PI - Math.atan( 1.0)
    end
  end

    # TODO: Check complementarity of acot and cot
    #assert_equal_float(1.0, Math.acot(Math.cot(1.0)), 1.0e-6)
    #assert_equal_float(1.0, Math.cot(Math.acot(1.0)), 1.0e-6)
    #assert_equal_float(2.0, Math.acot(Math.cot(2.0)), 1.0e-6)
    #assert_equal_float(2.0, Math.cot(Math.acot(2.0)), 1.0e-6)

    # TODO: Check consistency of atan2 and acot
    #assert_equal_float(Math.atan2(1.0, 1.0), Math.acot(1.0), 1.0e-6)
    #assert_equal_float(Math.atan2(1.0, 2.0), Math.acot(2.0), 1.0e-6)

end
