require 'facets/math/root'
require 'facets/numeric/range'

test_case Math do

  class_method :root do
    test do
      Math.root( 64.0,    3.0).range(1.0e-6).assert === 4.0
      Math.root(  0.729,  3.0).range(1.0e-6).assert === 0.9
      Math.root(  2.0,   -0.5).range(1.0e-6).assert === 0.25
      Math.root(  0.25,  -1.0/3).range(1.0e-6).assert === 64.0
    end
  end

end
