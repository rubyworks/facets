
class String

  # Like #index but returns a Range.
  #
  #   "This is a test!".range('test')  #=> 10..13
  #
  def range(s, offset=0)
    if self.index(s, offset)
      return ($~.begin(0))..($~.end(0)-1)
    end
    nil
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

    def test_range
      assert_equal( (1..3), "a123a567a9".range(/123/) )
      assert_equal( (0..0), "a123a567a9".range(/a/) )
    end

  end

=end
