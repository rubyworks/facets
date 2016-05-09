
class String

  # Returns an array of characters.
  #
  #   "abc\n123".lines  #=> ["abc","123"]
  #
  def lines
    self.split(/\n/)
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

    def test_lines
      assert_equal( ['a','b','c'], "a\nb\nc".lines )
    end

  end

=end
