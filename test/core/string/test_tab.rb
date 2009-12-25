require 'facets/string/tab'
require 'test/unit'

class TC_String_Tab < Test::Unit::TestCase

  def test_tab
    a = "xyz".tab(4)
    assert_equal( '    ', a[0..3] )
    # Need to expand on this
  end

end

