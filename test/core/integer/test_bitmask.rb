covers 'facets/integer/bitmask'

testcase Integer do

  unit :bit do
    0.bit(0).assert == 1
    0.bit(1).assert == 2
    0.bit(2).assert == 4
    0.bit(3).assert == 8
  end

  unit :bit => "negate" do
    1.bit(~0).assert == 0
    2.bit(~1).assert == 0
    4.bit(~2).assert == 0
    8.bit(~3).assert == 0
  end

  unit :bit_clear do
    1.bit_clear(0).assert == 0
    2.bit_clear(1).assert == 0
    4.bit_clear(2).assert == 0
    8.bit_clear(3).assert == 0
  end

  unit :bit? do
    a = 8
    assert(! a.bit?(0))
    assert(! a.bit?(1))
    assert(! a.bit?(2))
    assert(  a.bit?(3))
    assert(! a.bit?(4))
    assert(! a.bit?(5))
  end

  unit :bitmask do
    a =  1
    m = Bit(4)
    a = a.bitmask(m)
    a.assert == 17
    assert( a.bitmask?(m) )
  end

  unit :bitmask? do
    7.assert.bitmask?(7)
    7.assert.bitmask?(5)
    8.refute.bitmask?(3)
  end

end

testcase Kernel do

  unit :Bit do
    n = Bit(4)
    n.assert == 16
  end

end

