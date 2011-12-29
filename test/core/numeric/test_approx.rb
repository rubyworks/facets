covers 'facets/numeric/approx'

test_case Numeric do

  method :approx? do

    test do
      f = 10.006
      assert( f.approx?(10, 0.1) )
      assert( 100.4.approx?(100.6, 1) )
    end

  end

  method :close? do

    test do
      f = 10.006
      assert( f.close?(10, 0.1) )
      assert( 100.4.close?(100.6, 1) )
    end

  end

end

