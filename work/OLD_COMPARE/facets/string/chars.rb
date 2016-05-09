
class String

  # Returns an array of characters.
  #
  #   "abc".chars  #=> ["a","b","c"]
  #
  def chars
    self.split(//)
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

    def test_chars
      assert_equal( ["a","b","c"], "abc".chars )
      assert_equal( ["a","b","\n","c"], "ab\nc".chars )
    end

  end

=end
