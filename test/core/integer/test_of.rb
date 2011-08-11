covers 'facets/integer/of'

test_case Integer do

  method :of do

    test do
      a = 4
      b = a.of{ |i| i*2 }
      b.assert == [0,2,4,6]
    end

  end

  method :times_collect do

    test do
      a = 4
      b = a.times_collect{ |i| i*2 }
      b.assert == [0,2,4,6]
    end

  end

  method :times_map do

    test do
      a = 4
      b = a.times_map{ |i| i*2 }
      b.assert == [0,2,4,6]
    end

  end

end

