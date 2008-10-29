require 'facets/string/divide'
require 'test/unit'

class TC_String_Divide < Test::Unit::TestCase

  def test_divide
    s = "<p>This<b>is</b>a test.</p>"
    d = s.divide( /<.*?>/ )
    e = ["<p>This", "<b>is", "</b>a test.", "</p>"]
    assert_equal(e, d)
  end

end

