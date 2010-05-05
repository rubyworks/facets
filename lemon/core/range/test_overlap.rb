Covers 'facets/range/overlap'

Case Range do

  Unit :overlap? do
    assert( (4..5).overlap?(3..6) )
    assert(! (7..9).overlap?(3..6) )
  end

end

