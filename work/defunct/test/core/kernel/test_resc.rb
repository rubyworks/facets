require 'facets/kernel/resc'
require 'test/unit'

class TestKernelResc < Test::Unit::TestCase

  def test_resc
    assert_equal( Regexp.escape("'jfiw0[]4"), resc("'jfiw0[]4") )
    assert_equal( Regexp.escape("/////"), resc("/////") )
  end

end

