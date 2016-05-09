
class String

  # Converts a string to camelcase. By default capitalization
  # occurs on whitespace and underscores. By setting the first
  # parameter to <tt>true</tt> the first character can also be
  # captizlized. The second parameter can be assigned a valid
  # Regualr Expression characeter set to determine which
  # characters to match for capitalizing subsequent parts of
  # the string.
  #
  #   "this_is a test".camelcase             #=> "thisIsATest"
  #   "this_is a test".camelcase(true)       #=> "ThisIsATest"
  #   "this_is a test".camelcase(true, ' ')  #=> "This_isATest"
  #
  def camelcase( first=false, on='_\s' )
    if first
      gsub(/(^|[#{on}]+)([A-Za-z])/){ $2.upcase }
    else
      gsub(/([#{on}]+)([A-Za-z])/){ $2.upcase }
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

    def test_camelcase
      assert_equal( "abcXyz", "abc_xyz".camelcase )
      assert_equal( "abcXyz", "abc xyz".camelcase )
      assert_equal( "abcXyz", "abc  xyz".camelcase )
      assert_equal( "abcXyz", "abc\txyz".camelcase )
      assert_equal( "abcXyz", "abc\nxyz".camelcase )
      assert_equal( "abcXyz", "abc____xyz".camelcase )
    end

    def test_camelcase_true
      assert_equal( "AbcXyz", "abc_xyz".camelcase(true) )
      assert_equal( "AbcXyz", "abc xyz".camelcase(true) )
      assert_equal( "AbcXyz", "abc  xyz".camelcase(true) )
      assert_equal( "AbcXyz", "abc\txyz".camelcase(true) )
      assert_equal( "AbcXyz", "abc\nxyz".camelcase(true) )
    end

  end

=end
