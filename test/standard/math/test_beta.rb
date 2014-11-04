require 'facets/math/beta'

test_case Math do

  class_method :beta do
    test do
      Math.beta(1.0, 1.0).range(1.0e-6).assert === 1.0
      Math.beta(1.0, 2.0).range(1.0e-6).assert === 0.5
      Math.beta(1.0, 3.0).range(1.0e-6).assert === 1.0 /  3.0
      Math.beta(2.0, 1.0).range(1.0e-6).assert === 0.5
      Math.beta(2.0, 2.0).range(1.0e-6).assert === 1.0 /  6.0
      Math.beta(2.0, 3.0).range(1.0e-6).assert === 1.0 / 12.0
      Math.beta(3.0, 1.0).range(1.0e-6).assert === 1.0 /  3.0
      Math.beta(3.0, 2.0).range(1.0e-6).assert === 1.0 / 12.0
      Math.beta(3.0, 3.0).range(1.0e-6).assert === 1.0 / 30.0
    end
  end

end
