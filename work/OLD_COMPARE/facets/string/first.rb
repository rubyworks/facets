
require 'facets/string/patterns'
require 'facets/string/shatter'
require 'facets/string/last'

class String

  # Returns the first separation of a string.
  # Default seperation is by character.
  #
  #   "Hello World".first       #=> "H"
  #   "Hello World".first(' ')  #=> "Hello"
  #
  def first(separator_pattern=//)
    pattern = self.class.patterns(separator_pattern)
    split(separator_pattern).at(0)
  end

  # Removes the first separation from a string.
  # Defualt separation is by characters.
  #--
  # If a zero-length record separator is supplied,
  # the string is split on /\n+/. If the record
  # separator is set to <tt>nil</tt>, then the
  # string is split on characters.
  #++
  #
  #   a = "Hello World"
  #   a.first!       #=> "H"
  #   a              #=> "ello World"
  #
  #   a = "Hello World"
  #   a.first!(' ')  #=> "Hello"
  #   a              #=> "World"
  #
  def first!(separator_pattern=//)
    pattern = self.class.patterns(separator_pattern)
    a = shatter(pattern)
    r = a.first
    a.shift
    a.shift
    replace( a.join('') )
    return r
  end

  # Prepends to a string.
  #
  #   "Hello World".first = "Hello,"  #=> "Hello, Hello World"
  #--
  # Should this replace first char?
  #++
  def first=( x )
    insert(0, x.to_s)
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

    def test_first
      assert_equal( "a", "abcxyz".first )
      assert_equal( "ax", "ax by cz".first(' ') )
      assert_equal( "a", "a\nb\nc".first("\n") )
    end

    def test_first_eq
      s = "abc"
      s.first = "123"
      assert_equal( "123abc", s )
      s = "a\nbc"
      s.first = "123"
      assert_equal( "123a\nbc", s )
    end

    def test_first!
      s = "a\nbc"
      s.first!("\n")
      assert_equal( "bc", s )
    end

  end

=end
