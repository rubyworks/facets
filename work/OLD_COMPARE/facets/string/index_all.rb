
class String

  # Like index but returns an array of all index locations.
  # The reuse flag allows the trailing portion of a match to be 
  # reused for subsquent matches.
  #
  #   "abcabcabc".index_all('a')  #=> [0,3,6]
  #
  def index_all(s, reuse=false)
    ia = []; i = 0
    while (i = self.index(s,i))
      ia << i
      i += (reuse ? 1 : $~.length)
    end
    ia
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

    def test_index_all
      assert_equal( [0,4,8], "a123a567a9".index_all(/a/) )
    end

  end

=end
