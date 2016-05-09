
class String

  # Upacks string into bytes.
  #
  def bytes
    self.unpack('C*')
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

  class TestStringBytes < Test::Unit::TestCase
    def test_bytes
      s = "abc"
      assert_equal( s.unpack('C*'), s.bytes )
    end
  end

=end

