
class String

  # Breaks a string up into an array based on a regular expression.
  # Similar to scan, but includes the matches.
  #
  #   s = "<p>This<b>is</b>a test.</p>"
  #   s.divide( /\<.*?\>/ )
  #
  # _produces_
  #
  #   ["<p>This", "<b>is", "</b>a test.", "</p>"]
  #
  def divide( re )
    re2 = /#{re}.*?(?=#{re}|\Z)/
    self.scan(re2) #{re}(?=#{re})/)
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
      sh = s.divide( /<.*?>/ )
      e = ["<p>This", "<b>is", "</b>a test.", "</p>"]
      assert_equal(e, sh)
    end

  end

=end
