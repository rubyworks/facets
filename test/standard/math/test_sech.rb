require 'facets/math/sech'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :sech do
    test do
      Math.sech(1.0).range(1.0e-6).assert === 1.0 / Math.cosh(1.0)
      Math.sech(2.0).range(1.0e-6).assert === 1.0 / Math.cosh(2.0)
    end
  end

    # TODO: Check complementarity of cosh and sech
    #assert_equal_float(1.0, Math.sech(-2.0) * Math.cosh(-2.0), 1.0e-6)
    #assert_equal_float(1.0, Math.sech(-1.0) * Math.cosh(-1.0), 1.0e-6)
    #assert_equal_float(1.0, Math.sech( 1.0) * Math.cosh( 1.0), 1.0e-6)
    #assert_equal_float(1.0, Math.sech( 2.0) * Math.cosh( 2.0), 1.0e-6)

end
