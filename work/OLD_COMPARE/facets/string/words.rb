
class String

  # Returns an array of characters.
  #
  #   "abc 123".words  #=> ["abc","123"]
  #
  def words
    self.split(/\s+/)
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

    def test_001
      x = "a b c\nd e"
      assert_equal( ['a','b','c','d','e'], x.words )
    end

    def test_002
      x = "ab cd\nef"
      assert_equal( ['ab','cd','ef'], x.words )
    end

    def test_003
      x = "ab cd \n ef-gh"
      assert_equal( ['ab','cd','ef-gh'], x.words )
    end

  end

=end
