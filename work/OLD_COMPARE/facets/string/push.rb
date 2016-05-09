
class String

  # Polymorphic with Array of characters.
  def push(str=' ')
    concat(str)
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
      #assert_raises( ArgumentError ) { @a.push }
      assert_raises( ArgumentError ) { @a.push(1,2) }
    end

    def test_002
      assert_equal( "0", @a.push("0") )
      assert_equal( "01", @a.push("1") )
      assert_equal( "012", @a.push("2") )
      assert_equal( "0123", @a.push("3") )
      assert_equal( "01234", @a.push("4") )
      assert_equal( "012345", @a.push("5") )
    end

  end

=end
