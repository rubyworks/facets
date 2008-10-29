require 'facets/kernel/object_class.rb'
require 'facets/kernel/__class__.rb'
require 'test/unit'

class TCKernel < Test::Unit::TestCase

  def test_object_class
    assert_equal( self.class, self.object_class )
  end

  def test__class__
    assert_equal( self.class, self.__class__ )
  end

end
