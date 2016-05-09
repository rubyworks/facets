#--
# Credit goes to Gavin Kistner.
# Also special mention to Dayne Broderson.
#++

class String

  # Word wrap a string not exceeding max width.
  #
  #   puts "this is a test".word_wrap(4)
  #
  # _produces_
  #
  #   this
  #   is a
  #   test
  #
  def word_wrap( col_width=80 )
    self.dup.word_wrap!( col_width )
  end

  # As with #word_wrap, but modifies the string in place.
  #
  def word_wrap!( col_width=80 )
    self.gsub!( /(\S{#{col_width}})(?=\S)/, '\1 ' )
    self.gsub!( /(.{1,#{col_width}})(?:\s+|$)/, "\\1\n" )
    self
  end

  # old def

  #def word_wrap(max=80)
  #  c = dup
  #  c.word_wrap!(max)
  #  c
  #end

  #def word_wrap!(max=80)
  #  raise ArgumentError, "Wrap margin too low: #{n}" if max <= 2
  #  #gsub!( Regexp.new( "(.{1,#{max-1}}\\w)\\b\\s*" ), "\\1\n")
  #  gsub!( /(.{1,#{max-1}}\S)([ ]|\n)/, "\\1\n")
  #end

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

    def test_word_wrap
      assert_equal "abcde\n12345\nxyzwu\n", "abcde 12345 xyzwu".word_wrap(5)
      assert_equal "abcd\n1234\nxyzw\n", "abcd 1234 xyzw".word_wrap(4)
      assert_equal "abc\n123\n", "abc 123".word_wrap(4)
      assert_equal "abc \n123\n", "abc  123".word_wrap(4)
      assert_equal "abc \n123\n", "abc     123".word_wrap(4)
    end

    def test_word_wrap!
      w = "abcde 12345 xyzwu" ; w.word_wrap!(5)
      assert_equal("abcde\n12345\nxyzwu\n", w)
      w = "abcd 1234 xyzw" ; w.word_wrap!(4)
      assert_equal("abcd\n1234\nxyzw\n", w)
      w = "abc 123" ; w.word_wrap!(4)
      assert_equal "abc\n123\n", w
      w = "abc  123" ; w.word_wrap!(4)
      assert_equal("abc \n123\n", w)
      w = "abc     123" ; w.word_wrap!(4)
      assert_equal("abc \n123\n", w)
    end

#   def test_word_wrap
#     assert_equal "abcde-\n12345-\nxyzwu\n", "abcde12345xyzwu".word_wrap(6,2)
#     assert_equal "abcd-\n1234-\nxyzw\n", "abcd1234xyzw".word_wrap(5,2)
#     assert_equal "abc \n123\n", "abc 123".word_wrap(4,2)
#     assert_equal "abc \n123\n", "abc  123".word_wrap(4,2)
#     assert_equal "abc \n123\n", "abc     123".word_wrap(4,2)
#   end

  end

=end
