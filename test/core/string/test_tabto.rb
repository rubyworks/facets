require 'facets/string/tabto'
require 'test/unit'

class TC_String_Tabto < Test::Unit::TestCase

  def test_tabto
    a = "xyz".tabto(4)
    assert_equal( '    ', a[0..3] )
    # Need to expand on this
  end

end

