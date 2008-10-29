require 'facets/module/pathize'
require 'test/unit'

class TestClassPathize < Test::Unit::TestCase

  def test_pathize
    assert_equal( Test::Unit::TestCase.pathize, 'test/unit/test_case' )
  end

  #def test_methodize
  #  assert_equal( Test::Unit::TestCase.methodize, 'test__unit__test_case' )
  #end

end

