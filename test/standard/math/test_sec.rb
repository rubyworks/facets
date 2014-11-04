require 'facets/math/sec'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :sec do
    test do
      Math.sec(1.0).range(1.0e-6).assert === 1.0 / Math.cos(1.0)
      Math.sec(2.0).range(1.0e-6).assert === 1.0 / Math.cos(2.0)
    end
  end

    # TODO: Check complementarity of cos and sec
    #assert_equal_float(1.0, Math.sec(-2.0) * Math.cos(-2.0), 1.0e-6)
    #assert_equal_float(1.0, Math.sec(-1.0) * Math.cos(-1.0), 1.0e-6)
    #assert_equal_float(1.0, Math.sec( 1.0) * Math.cos( 1.0), 1.0e-6)
    #assert_equal_float(1.0, Math.sec( 2.0) * Math.cos( 2.0), 1.0e-6)

end
