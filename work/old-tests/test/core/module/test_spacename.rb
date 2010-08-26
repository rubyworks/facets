require 'facets/module/spacename.rb'
require 'test/unit'

class TestModuleSpaceName < Test::Unit::TestCase

  def test_spacename
    assert_equal( 'Test::Unit', Test::Unit::TestCase.spacename )
    assert_equal( 'Test::Unit', ::Test::Unit::TestCase.spacename )
    assert_equal( '', Test.spacename )
    assert_equal( '', ::Test.spacename )
  end

end

