require 'facets/module/basename.rb'
require 'test/unit'

class TestModuleBasename < Test::Unit::TestCase

  def test_basename
    assert_equal( "TestCase", ::Test::Unit::TestCase.basename )
  end

end

