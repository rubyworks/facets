require 'facets/math/sign'

test_case Math do

  class_method :sign do
    test do
      Math.sign(-3.1).assert == -1.0
      Math.sign( 0.0).assert ==  0.0
      Math.sign( 3.1).assert ==  1.0
    end
  end

end

