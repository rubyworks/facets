
require 'facets/string/patterns'
require 'facets/string/shatter'
require 'facets/string/first'

class String

  # Returns the last separation of a string.
  # Default separation is by character.
  #
  #   "Hello World".last(' ')  #=> "World"
  #
  def last(separator_pattern=//)
    pattern = self.class.patterns(separator_pattern)
    self.split(separator_pattern).at(-1)
  end

  # Appends to a string.
  #
  #   "Hello World".last = ", Bye."  #=>  "Hello World, Bye."
  #
  def last=(str)
    self << str
  end

  # Removes the last separation from a string.
  # Default seperation is by characeter.
  #--
  # If a zero-length record separator is supplied,
  # the string is split on /\n+/. If the record
  # separator is set to <tt>nil</tt>, then the
  # string is split on characters.
  #++
  #
  #   a = "Hello World"
  #   a.last!       #=> "d"
  #   a             #=> "Hello Worl"
  #
  #   a = "Hello World"
  #   a.last!(' ')  #=> "World"
  #   a             #=> "Hello"
  #
  def last!(separator_pattern=//)
    pattern = self.class.patterns(separator_pattern)
    a = shatter(pattern)
    r = a.last
    a.pop
    a.pop
    replace( a.join('') )
    return r
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

    def test_last
      assert_equal( "z", "abcxyz".last )
      assert_equal( "cz", "ax by cz".last(' ') )
      assert_equal( "c", "a\nb\nc".last("\n") )
    end

    def test_last_eq
      s = "abc"
      s.last = "123"
      assert_equal( "abc123", s )
      s = "a\nbc"
      s.last = "123"
      assert_equal( "a\nbc123", s )
    end

    def test_last!
      s = "abc"
      s.last!
      assert_equal( "ab", s )
      s = "a b c"
      s.last!(' ')
      assert_equal( "a b", s )
    end

  end

=end
