require 'facets/math/exp10'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :exp10 do
    test do
      Math.exp10(0.0).range(1.0e-6).assert === 1.0
      Math.exp10(0.5).range(1.0e-6).assert === Math.sqrt(10.0)
      Math.exp10(1.0).range(1.0e-6).assert === 10.0
    end
  end

end
