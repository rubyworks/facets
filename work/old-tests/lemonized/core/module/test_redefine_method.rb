require 'facets/module/redefine_method'
require 'test/unit'

class Test_Module_RedefineMethod < Test::Unit::TestCase

  # redef_method

  def a; "a"; end

  redefine_method(:a) { nil }

  def test_redefine_method
    assert_equal( nil, a )
  end

  # redef

  def b; "b"; end

  redef(:b) { "x" }

  def test_redef
    assert_equal( "x", b )
  end

end

