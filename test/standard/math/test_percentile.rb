covers 'facets/math/percentile'

test_case Math do

  class_method :percentile do
    test do
      a = [1,1,2,2,3,3,3,4]
      r = Math.percentile(a,75)
      r.assert == 3.0
    end
  end

end
