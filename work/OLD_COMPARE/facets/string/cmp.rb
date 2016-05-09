
class String

  # Compare method that takes length into account.
  # Unlike #<=>, this is compatible with #succ.
  #
  #   "abc".cmp("abc")   #=>  0
  #   "abcd".cmp("abc")  #=>  1
  #   "abc".cmp("abcd")  #=> -1
  #   "xyz".cmp("abc")   #=>  1
  #
  def cmp(other)
    return -1 if length < other.length
    return 1 if length > other.length
    self <=> other  # alphabetic compare
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

    def test_cmp
      assert_equal( 0, "abc".cmp("abc") )
      assert_equal( -1, "abc".cmp("abcd") )
      assert_equal( 1, "abcd".cmp("abc") )
      assert_equal( -1, "abc".cmp("bcd") )
      assert_equal( 1, "bcd".cmp("abc") )
    end

  end

=end
