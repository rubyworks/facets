
class String

  def to_time
    require 'time'
    Time.parse(self)
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

    def test_to_time
      s = "2:31:15 PM"
      t = s.to_time
      assert_equal( 14, t.hour )
      assert_equal( 31, t.min )
      assert_equal( 15, t.sec )
    end

  end

=end
