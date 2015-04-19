covers 'facets/array/uniq_by'

test_case Array do

  method :uniq_by! do

    test do
      e = [-5, -4, -3, -2, -1, 0]
      r = (-5..5).to_a
      r.uniq_by!{ |i| i*i }
      r.assert == e
    end

    test do
      e = [5, 4, 3, 2, 1, 0]
      r = (-5..5).to_a.reverse
      r.uniq_by!{ |i| i*i }
      r.assert == e
    end

  end

end

