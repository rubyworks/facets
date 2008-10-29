require 'facets/module/modspace.rb'
require 'test/unit'

class TestModuleModSpace < Test::Unit::TestCase

  def test_modspace
    assert_equal( Test::Unit, Test::Unit::TestCase.modspace )
    assert_equal( ::Test::Unit, ::Test::Unit::TestCase.modspace )
    assert_equal( Object, ::Test.modspace )
  end

end

