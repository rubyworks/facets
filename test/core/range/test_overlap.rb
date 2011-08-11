covers 'facets/range/overlap'

test_case Range do

  method :overlap? do

    test do
      assert( (4..5).overlap?(3..6) )
      assert(! (7..9).overlap?(3..6) )
    end

  end

end

