
class String

  def unshift( str=' ' )
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
      @a = ""
    end

    def test_001
      assert_raises( ArgumentError ) { @a.unshift(1,2) }
    end

    def test_002
      assert_equal( "0", @a.unshift("0") )
      assert_equal( "10", @a.unshift("1") )
      assert_equal( "210", @a.unshift("2") )
      assert_equal( "3210", @a.unshift("3") )
      assert_equal( "43210", @a.unshift("4") )
      assert_equal( "543210", @a.unshift("5") )
    end

  end

=end
