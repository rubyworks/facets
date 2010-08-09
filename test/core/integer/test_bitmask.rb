Covers 'facets/integer/bitmask'

Case Integer do

  Unit :bit do
    0.bit(0).assert == 1
    0.bit(1).assert == 2
    0.bit(2).assert == 4
    0.bit(3).assert == 8
  end

  Unit :bit => "negate" do
    1.bit(~0).assert == 0
    2.bit(~1).assert == 0
    4.bit(~2).assert == 0
    8.bit(~3).assert == 0
  end

  Unit :clear_bit do
    1.clear_bit(0).assert == 0
    2.clear_bit(1).assert == 0
    4.clear_bit(2).assert == 0
    8.clear_bit(3).assert == 0
  end

  Unit :bit? do
    a = 8
    assert(! a.bit?(0))
    assert(! a.bit?(1))
    assert(! a.bit?(2))
    assert(  a.bit?(3))
    assert(! a.bit?(4))
    assert(! a.bit?(5))
  end

  Unit :bitmask do
    a =  1
    m = Bit(4)
    a = a.bitmask(m)
    a.assert == 17
    assert( a.bitmask?(m) )
  end

end

Case Kernel do

  Unit :Bit do
    n = Bit(4)
    n.assert == 16
  end

end

