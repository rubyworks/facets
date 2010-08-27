require 'facets/kernel/instance_assign.rb'
require 'test/unit'

class TestKernelInstanceAssign < Test::Unit::TestCase

  def test_instance_assign
    ahash = { "z"=>0, "@a"=>1, "@b"=>2 } #, "@@a"=>3 }
    instance_assign( ahash )
    assert_equal( 0, @z )
    assert_equal( 1, @a )
    assert_equal( 2, @b )
    #assert_equal( 3, @@a )
  end

end

