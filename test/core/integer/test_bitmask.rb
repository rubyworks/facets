covers 'facets/integer/bitmask'

test_case Integer do

  method :bit do
    test do
      0.bit(0).assert == 1
      0.bit(1).assert == 2
      0.bit(2).assert == 4
      0.bit(3).assert == 8
    end
  end

  method :bit do
    test "negate" do
      1.bit(~0).assert == 0
      2.bit(~1).assert == 0
      4.bit(~2).assert == 0
      8.bit(~3).assert == 0
    end
  end

  method :bit_clear do
    test do
      1.bit_clear(0).assert == 0
      2.bit_clear(1).assert == 0
      4.bit_clear(2).assert == 0
      8.bit_clear(3).assert == 0
    end
  end

  method :bit? do
    test do
      a = 8
      assert(! a.bit?(0))
      assert(! a.bit?(1))
      assert(! a.bit?(2))
      assert(  a.bit?(3))
      assert(! a.bit?(4))
      assert(! a.bit?(5))
    end
  end

  method :bitmask do
    test do
      a =  1
      m = Bit(4)
      a = a.bitmask(m)
      a.assert == 17
      assert( a.bitmask?(m) )
    end
  end

  method :bitmask? do
    test do
      7.assert.bitmask?(7)
      7.assert.bitmask?(5)
      8.refute.bitmask?(3)
    end
  end

end

test_case Kernel do

  method :Bit do
    test do
      n = Bit(4)
      n.assert == 16
    end
  end

end
