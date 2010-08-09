require 'facets/kernel/method'
require 'test/unit'

class TestKernelMethod < Test::Unit::TestCase

  class TestWith
    def foo ; end
  end

  def test_method!
    t = TestWith.new
    assert_equal( t.method!(:foo).__id__, t.method!(:foo).__id__ )
    assert_not_equal( t.method(:foo).__id__, t.method(:foo).__id__ )
  end

end
