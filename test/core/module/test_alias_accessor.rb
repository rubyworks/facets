require 'facets/module/alias_accessor'
require 'test/unit'

class Test_Module_Alias_Accessor < Test::Unit::TestCase

  class X
    attr_accessor :x
    alias_accessor :y, :x
  end

  def test_alias_accessor
    x = X.new
    x.x = 10
    assert_equal( 10, x.x )
    assert_equal( 10, x.y )
    x.y = 20
    assert_equal( 20, x.x )
    assert_equal( 20, x.y )
  end

end

