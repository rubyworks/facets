
class String

  # Like push but works from the other end of the string.

  def pot( str=' ' )
    insert(0, str)
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

    def setup
      @a =  ""
    end

    def test_001
      assert_raises( ArgumentError ) { @a.pot(1,2) }
    end

    def test_002
      assert_equal( "0", @a.pot("0") )
      assert_equal( "10", @a.pot("1") )
      assert_equal( "210", @a.pot("2") )
      assert_equal( "3210", @a.pot("3") )
      assert_equal( "43210", @a.pot("4") )
      assert_equal( "543210", @a.pot("5") )
    end

  end

=end

