
class String

  # Retrns _n_ characters of the string. If _n_ is positive
  # the characters are from the beginning of the string.
  # If _n_ is negative from the end of the string.
  #
  # Alternatively a replacement string can be given, which will
  # replace the _n_ characters.
  #
  def nchar( n, replacement=nil )
    if replacement
      s = self.dup
      n > 0 ? (s[0...n] = replacement) : (s[n..-1] = replacement)
      return s
    else
      n > 0 ? self[0...n] : self[n..-1]
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

    def test_nchar
      assert_equal( "abc", "abcxyz".nchar(3) )
      assert_equal( "xyz", "abcxyz".nchar(-3) )
      assert_equal( "HIxyz", "abcxyz".nchar(3, 'HI') )
      assert_equal( "abcHI", "abcxyz".nchar(-3, 'HI') )
    end

  end

=end
