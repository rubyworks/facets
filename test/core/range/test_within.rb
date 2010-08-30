covers 'facets/range/within'

testcase Range do

  unit :within? do
    assert( (4..5).within?(3..6) )
    assert( (3..6).within?(3..6) )
    assert(! (2..5).within?(3..6) )
    assert(! (5..7).within?(3..6) )
  end

end
