require 'facets/hash/to_module'
require 'test/unit'

class TC_Hash_To_Module < Test::Unit::TestCase

  def test_to_module
    h = { :a=>1, :b=>2 }
    m = h.to_module
    assert(Module === m)
  end

  def test_to_module_methods
    h = { :a=>1, :b=>2 }
    m = h.to_module
    x = Class.new{ include m }.new
    assert_equal( 1, x.a )
    assert_equal( 2, x.b )
  end

end

