require 'facets/math/acoth'
require 'facets/math/coth'
require 'facets/numeric/range'  # used to test within a precision

test_case Math do

  class_method :acoth do
    test do
      Math.acoth(1.5).range(1.0e-6).assert === 0.5 * Math.log(5.0)
      Math.acoth(5.0).range(1.0e-6).assert === 0.5 * Math.log(1.5)
    end

    # 1.0e-6
    test "check complementarity of acoth and coth" do
      Math.acoth(Math.coth( 1.5)).range(1.0e-6).assert === 1.5
      Math.coth(Math.acoth( 1.5)).range(1.0e-6).assert === 1.5
      Math.acoth(Math.coth(-1.5)).range(1.0e-6).assert === -1.5
      Math.coth(Math.acoth(-1.5)).range(1.0e-6).assert === -1.5
    end
  end

end
