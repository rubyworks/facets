require 'facets/enumerable/inject'
require 'test/unit'

class TestEnumerableInject < Test::Unit::TestCase

  def test_inject!
    r = [1,2,3,4,5].inject!([]){ |a,i| a << i % 2 }
    e = [1,0,1,0,1]
    assert_equal(e, r)
  end

  def test_inject_equal!
    r = [].inject!([]){ |a,i| a << i % 2 }
    e = []
    assert_equal(e, r)
  end

end
