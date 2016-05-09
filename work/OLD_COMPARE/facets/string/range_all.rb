require 'facets/string/range'

class String

  # Like #index_all but returns an array of Ranges.
  #
  #   "abc123abc123".range_all('abc')  #=> [0..2, 6..8]
  #
  #--
  # Note: should add offset ?
  #++
  def range_all(s, reuse=false)
    r = []; i = 0
    while i < self.length
      rng = range(s, i)
      if rng
        r << rng
        i += reuse ? 1 : rng.end + 1
      else
        break
      end
    end
    r.uniq
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_range_all
      assert_equal( [ (1..3), (5..7) ], "a123a123a9".range_all(/123/) )
      assert_equal( [ (0..0), (4..4), (8..8) ], "a123a567a9".range_all(/a/) )
    end

  end

=end
