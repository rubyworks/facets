require 'facets/math/floor'

test_case Math do

  class_method :floor do
    test do
      Math.floor( 1.99999).assert == 1
      Math.floor( 1.5    ).assert == 1
      Math.floor( 1.00001).assert == 1
      Math.floor( 0.99999).assert == 0
      Math.floor( 0.5    ).assert == 0
      Math.floor( 0.00001).assert == 0
      Math.floor(-0.00001).assert == -1
      Math.floor(-0.5    ).assert == -1
      Math.floor(-0.99999).assert == -1
      Math.floor(-1.00001).assert == -2
      Math.floor(-1.5    ).assert == -2
      Math.floor(-1.99999).assert == -2
    end
  end

end

