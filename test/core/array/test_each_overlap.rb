covers 'facets/array/each_overlap'

test_case Array do

  method :each_overlap do

    test do
      a = [1,2,3,4,5]
      r = []
      a.each_overlap(2,1) { |x| r << x } 
      r.assert == [[1,2],[2,3],[3,4],[4,5]]
    end

    test do
      a = [1,2,3,4,5,6,7]
      r = []
      a.each_overlap(3,1) { |x| r << x } 
      r.assert == [[1,2,3],[3,4,5],[5,6,7]]
    end

    test do
      a = [1,2,3,4,5]
      r = []
      a.each_overlap(3,2) { |x| r << x } 
      r.assert == [[1,2,3],[2,3,4],[3,4,5]]
    end

  end

end

