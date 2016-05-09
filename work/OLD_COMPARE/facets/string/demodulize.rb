require 'facets/string/basename'

class String

  alias_method :demodulize, :basename  # a la Rails

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
      @a =  "Down::Bottom"
      @b =  "Further::Down::Bottom"
    end

    def test_001
      assert_raises( ArgumentError ) { @a.demodulize(1) }
    end

    def test_002
      assert_equal( "Bottom", @a.demodulize )
    end

    def test_003
      assert_equal( "Bottom", @b.demodulize )
    end
  end

=end
