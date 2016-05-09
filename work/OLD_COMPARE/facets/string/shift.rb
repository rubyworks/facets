class String
  def shift
    return '' if size == 0
    self[0] = ''
    self
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
      assert_raises( ArgumentError ) { @a.shift(1) }
    end

    def test_002
      assert_equal( "12345", @a.shift )
      assert_equal( "2345", @a.shift )
      assert_equal( "345", @a.shift )
      assert_equal( "45", @a.shift )
      assert_equal( "5", @a.shift )
      assert_equal( "", @a.shift )
      assert_equal( "", @a.shift )
    end

  end

=end
