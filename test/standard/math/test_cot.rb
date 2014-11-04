require 'facets/math/cot'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :cot do
    test do
      Math.cot(1.0).range(1.0e-6).assert === 1.0 / Math.tan(1.0)
      Math.cot(2.0).range(1.0e-6).assert === 1.0 / Math.tan(2.0) 
    end
  end

end
