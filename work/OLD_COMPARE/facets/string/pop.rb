
class String

  # Polymorphic with Array of characters.
  def pop
    return '' if size == 0
    r = self[-1,1]
    self[-1] = ''
    r #self
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
      @a =  "012345"
    end

    def test_001
      assert_raises( ArgumentError ) { @a.pop(1) }
    end

    def test_002
      assert_equal( "5", @a.pop )
      assert_equal( "01234", @a )
      assert_equal( "4", @a.pop )
      assert_equal( "0123", @a )
      assert_equal( "3", @a.pop )
      assert_equal( "012", @a )
      assert_equal( "2", @a.pop )
      assert_equal( "01", @a )
      assert_equal( "1", @a.pop )
      assert_equal( "0", @a )
      assert_equal( "0", @a.pop )
      assert_equal( "", @a )
      assert_equal( "", @a.pop )
      assert_equal( "", @a )
    end

  end

=end
