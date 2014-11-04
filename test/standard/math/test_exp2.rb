require 'facets/math/exp2'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :exp2 do
    test do
      Math.exp2(0.0).range(1.0e-6).assert === 1.0
      Math.exp2(0.5).range(1.0e-6).assert === Math.sqrt(2.0)
      Math.exp2(1.0).range(1.0e-6).assert === 2.0
    end
  end

end
