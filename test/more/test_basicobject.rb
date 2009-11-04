require 'facets/basicobject'
require 'test/unit'

class TestBasicObject < Test::Unit::TestCase

  class A < BasicObject
  end

  def setup
    @a = A.new
  end

  def test_ignore_new_kernel_methods
    Kernel.module_eval { def xxx ; end }
    assert_raises(NoMethodError) { @a.xxx }
  end

  def test_ignore_new_object_methods
    Object.class_eval { def yyy ; end }
    assert_raises(NoMethodError) { @a.yyy }
  end

  #def test_006
  #  Object.class_eval { def yyy ; end }
  #  assert( ! @a.object_self.methods.include?( 'yyy' ) )
  #end

  #def test_007
  #  Object.class_eval { def yyy ; end }
  #  assert( ! @a.object_class.method_defined?( :methods ) )
  #  assert( ! @a.object_self.methods.include?( :methods ) )
  #end

end
