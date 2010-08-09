require 'facets/module/methodize'
require 'test/unit'

class Test_Module_Methodize < Test::Unit::TestCase

  def test_methodize
    assert_equal( "test__unit__test_case", ::Test::Unit::TestCase.methodize )
  end

end

