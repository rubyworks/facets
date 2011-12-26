require 'facets/math/abs'

test_case Math do

  class_method :abs do
    test do
      Math.abs(-3.1).assert == 3.1
      Math.abs( 0.0).assert == 0.0
      Math.abs( 3.1).assert == 3.1
    end
  end

end
