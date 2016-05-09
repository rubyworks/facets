
class String

  # Turns a string into a regular expression.
  # By default it will escape all characters.
  # Use <tt>false</tt> argument to turn off escaping.
  #
  #   "[".to_re  #=> /\[/
  #
  def to_re(esc=true)
    Regexp.new((esc ? Regexp.escape(self) : self))
  end

  # Turns a string into a regular expression.
  # Unlike #to_re this will not escape characters.
  #
  #   "a?".to_rx  #=> /a?/
  #
  def to_rx
    Regexp.new(self)
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

    def test_to_re
      assert_equal( /abc/, "abc".to_re )
      assert_equal( /a\+bc/, "a+bc".to_re )
      assert_equal( /a+bc/, "a+bc".to_re(false) )
    end

  end

=end
