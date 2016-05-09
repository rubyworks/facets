class String

  # Returns a Regexp pattern based on the given
  # pattern string or symbolic name.
  #
  # Recognized names are:
  #
  # * :char
  # * :word
  # * :line
  #
  # They are also recognizied in plural form.
  #
  def self.patterns( pattern )
    case pattern
    when :char, :chars, :character, :characters
      pattern = //
    when :word, :words
      pattern = /\s+|\Z/
    when :line, :lines
      pattern = /\Z/
    when String
      pattern = Regexp.new(Regexp.escape(pattern))
    end
    pattern
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

  class TC01 < Test::Unit::TestCase

    def test_String_rand_letter
      assert_equal( //, String.patterns(//) )
      assert_equal( //, String.patterns(:chars) )
      assert_equal( /\ /, String.patterns(' ') )
    end

  end

=end
