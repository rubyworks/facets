require 'facets/math/sinc'

test_case Math do

  class_method :sinc do
    test do
      Math.sinc( 0.0).assert == 1.0
      Math.sinc( 1.0).assert == Math.sin(1.0)
      Math.sinc(-1.0).assert == Math.sin(1.0)
      Math.sinc( 2.0).assert == 0.5 * Math.sin(2.0)
      Math.sinc(-2.0).assert == 0.5 * Math.sin(2.0)
    end
  end

end
