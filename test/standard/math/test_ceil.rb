require 'facets/math/ceil'

test_case Math do

  class_method :ceil do
    test do
      Math.ceil( 1.99999).assert == 2
      Math.ceil( 1.5    ).assert == 2
      Math.ceil( 1.00001).assert == 2
      Math.ceil( 0.99999).assert == 1
      Math.ceil( 0.5    ).assert == 1
      Math.ceil( 0.00001).assert == 1
      Math.ceil(-0.00001).assert == 0
      Math.ceil(-0.5    ).assert == 0
      Math.ceil(-0.99999).assert == 0
      Math.ceil(-1.00001).assert == -1
      Math.ceil(-1.5    ).assert == -1
      Math.ceil(-1.99999).assert == -1
    end
  end

end
