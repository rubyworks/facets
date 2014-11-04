require 'facets/math/cosec'

test_case Math do

  class_method :cosec do
    test do
      Math.cosec(-1.0).assert == 1.0 / Math.sin(-1.0)
      Math.cosec( 1.0).assert == 1.0 / Math.sin( 1.0)
    end
  end

  # TODO: Check complementarity of cosec and sin
  #assert_equal_float(1.0, Math.cosec(-2.0) * Math.sin(-2.0), 1.0e-6)
  #assert_equal_float(1.0, Math.cosec(-1.0) * Math.sin(-1.0), 1.0e-6)
  #assert_equal_float(1.0, Math.cosec( 1.0) * Math.sin( 1.0), 1.0e-6)
  #assert_equal_float(1.0, Math.cosec( 2.0) * Math.sin( 2.0), 1.0e-6)

end

