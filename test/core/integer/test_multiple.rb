covers 'facets/integer/multiple'

testcase Integer do

  unit :multiple? do
    assert( ! 1.multiple?(2) )
    assert(   2.multiple?(2) )
    assert( ! 5.multiple?(3) )
    assert(   6.multiple?(3) )
  end

end

