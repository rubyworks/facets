
class String

  # Returns an array of ranges mapping
  # the characters per line.
  #
  #   "this\nis\na\ntest".range_of_line
  #   #=> [0..4, 5..7, 8..9, 10..13]
  #
  def range_of_line
    offset=0; charmap = []
    self.each do |line|
      charmap << (offset..(offset + line.length - 1))
      offset += line.length
    end
    charmap
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

    def test_range_of_line
      a = "0123\n456\n78"
      ltcm = a.range_of_line
      assert_equal( [0..4, 5..8, 9..10], ltcm )
    end

  end

=end
