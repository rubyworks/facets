class String
  alias_method( :succ_once, :succ )
  # Allows #succ to take _n_ step increments.
  #
  #   "abc".succ      #=> "abd"
  #   "abc".succ(4)   #=> "abg"
  #   "abc".succ(24)  #=> "aca"
  #
  def succ(n=1)
    s = self
    n.times { s = s.succ_once }
    s
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

    def test_succ
      assert_equal( "b", "a".succ )
      assert_equal( "b", "a".succ(1) )
      assert_equal( "c", "a".succ(2) )
      assert_equal( "d", "a".succ(3) )
    end

  end

=end
