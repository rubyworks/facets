require 'facets/string/shatter'
require 'test/unit'

class TC_String_Shatter < Test::Unit::TestCase

  def test_shatter
    s = "<p>This<b>is</b>a test.</p>"
    sh = s.shatter( /<.*?>/ )
    e = ["<p>", "This", "<b>", "is", "</b>", "a test.", "</p>"]
    assert_equal(e, sh)
  end

end

