
class String

  # Breaks a string up into an array based on a regular expression.
  # Similar to scan, but includes the matches.
  #
  #   s = "<p>This<b>is</b>a test.</p>"
  #   s.shatter( /\<.*?\>/ )
  #
  # _produces_
  #
  #   ["<p>", "This", "<b>", "is", "</b>", "a test.", "</p>"]
  #
  def shatter( re )
    r = self.gsub( re ){ |s| "\1" + s + "\1" }
    while r[0,1] == "\1" ; r[0] = '' ; end
    while r[-1,1] == "\1" ; r[-1] = '' ; end
    r.split("\1")
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

    def test_shatter
      s = "<p>This<b>is</b>a test.</p>"
      sh = s.shatter( /<.*?>/ )
      e = ["<p>", "This", "<b>", "is", "</b>", "a test.", "</p>"]
      assert_equal(e, sh)
    end

  end

=end
