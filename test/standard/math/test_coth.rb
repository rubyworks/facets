require 'facets/math/coth'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :coth do
    test do
      Math.coth(1.0).range(1.0e-6).assert === 1.0 / Math.tanh(1.0)
      Math.coth(2.0).range(1.0e-6).assert === 1.0 / Math.tanh(2.0)
    end
  end

end
