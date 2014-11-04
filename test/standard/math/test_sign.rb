require 'facets/math/sign'

test_case Math do

  class_method :sign do
    test do
      Math.sign(-3.1).assert == -1.0
      Math.sign( 0.0).assert ==  0.0
      Math.sign( 3.1).assert ==  1.0
    end

    # Check complementarity of abs and sign
    #assert_equal_float(-2.0, Math.abs(-2.0) * Math.sign(-2.0), 1e-6)
    #assert_equal_float( 0.0, Math.abs( 0.0) * Math.sign( 0.0), 1e-6)
    #assert_equal_float( 3.0, Math.abs( 3.0) * Math.sign( 3.0), 1e-6)

  end

end

