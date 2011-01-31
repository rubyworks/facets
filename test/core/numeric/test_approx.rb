covers 'facets/numeric/approx'

testcase Numeric do

  unit :approx? do
    f = 10.006
    assert( f.approx?(10.01) )
    assert( f.approx?(10, 0.1) )
    assert( 100.4.approx?(100.6, 1) )
  end

end

