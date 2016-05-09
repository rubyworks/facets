
class String

  # Line wrap at width.
  #
  #   puts "1234567890".line_wrap(5)
  #
  # _produces_
  #
  #   12345
  #   67890
  #
  def line_wrap(width)
    s = gsub(/\t/,' '*4) # tabs default to 4 spaces.
    s = s.gsub(/\n/,' ')
    r = s.scan( /.{1,#{width}}/ )
    r.join("\n") << "\n"
  end

end

# This is alternateive from glue: worth providing?

  # Enforces a maximum width of a string inside an
  # html container. If the string exceeds this maximum width
  # the string gets wraped.
  #
  # Not really useful, better use the CSS overflow: hidden
  # functionality.
  #
  # === Input:
  # the string to be wrapped
  # the enforced width
  # the separator used for wrapping
  #
  # === Output:
  # the wrapped string
  #
  # === Example:
  #  text = "1111111111111111111111111111111111111111111"
  #  text = wrap(text, 10, " ")
  #  p text # => "1111111111 1111111111 1111111111"
  #
  # See the test cases to better understand the behaviour!

#   def self.wrap(string, width = 20, separator = " ")
#     return nil unless string
#
#     re = /([^#{separator}]{1,#{width}})/
#     wrapped_string = string.scan(re).join(separator)
#
#     return wrapped_string
#   end




#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_line_wrap
      assert_equal "abc\n123\n", "abc123".line_wrap(3)
      assert_equal "abcd\n123\n", "abcd123".line_wrap(4)
    end

  end

=end
