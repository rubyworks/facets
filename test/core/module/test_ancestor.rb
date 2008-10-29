require 'facets/module/ancestor.rb'
require 'test/unit'

class TestInclude < Test::Unit::TestCase

  def test_ancestor
    assert( self.class.ancestor?(::Test::Unit::TestCase) )
  end

end

