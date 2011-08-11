covers 'facets/integer/factorial'

test_case Integer do

  method :factorial do

    test do
      0.factorial.assert == 1
      1.factorial.assert == 1
      2.factorial.assert == 2
      3.factorial.assert == 6
      4.factorial.assert == 24
    end

  end

  method :fac do

    test do
      0.fac.assert == 1
      1.fac.assert == 1
      2.fac.assert == 2
      3.fac.assert == 6
      4.fac.assert == 24
    end

  end

end

