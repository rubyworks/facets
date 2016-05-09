
class String

  # Like #scan but returns MatchData ($~) rather
  # then matched string ($&).
  #
  def mscan(re) #:yield:
    if block_given?
      scan(re) { yield($~) }
    else
      m = []
      scan(re) { m << $~ }
      m
    end
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

    def test_mscan
      r = 'abc,def,gh'.mscan(/[,]/)
      assert( r.all?{ |md| MatchData === md } )
      assert_equal( 2, r.to_a.length )
      assert_equal( ',', r[0][0] )
      assert_equal( ',', r[1][0] )
    end

  end

=end
