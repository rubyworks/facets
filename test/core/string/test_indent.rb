require 'facets/string/indent'
require 'test/unit'

class TC_String_Indent < Test::Unit::TestCase

  def test_indent
    a = "xyz".indent(4)
    assert_equal( '    ', a[0..3] )
    # Need to expand on this
  end

end

