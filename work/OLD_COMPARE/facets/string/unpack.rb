
class String

  alias_method( :unpack_from_orgin, :unpack )
  # Upack with offset. Extends #unpack to allow a string 
  # to be unpacked starting at an offset position within it.
  #
  def unpack(format, offset=nil)
    if offset.nil?
      unpack_from_orgin(format)
    else
      self[offset..-1].unpack_from_orgin(format)
    end
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

    def test_unpack
      str, fmt = "abc\0", "Z*"
      assert_equal "abc", str.unpack(fmt).first
      assert_equal "abc", str.unpack(fmt, 0).first
      assert_equal "bc", str.unpack(fmt, 1).first
      assert_equal "bc", str.unpack(fmt, -3).first
      assert_equal "c", str.unpack(fmt, 2).first
      assert_equal "c", str.unpack(fmt, -2).first
      assert_equal "", str.unpack(fmt, 3).first
      assert_equal "", str.unpack(fmt, -1).first
    end

  end

=end
