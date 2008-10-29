require 'facets/kernel/tap'
require 'test/unit'

class TestKernelTap < Test::Unit::TestCase

  def test_tap
    x = "foo"
    r = ("foobar".tap{ gsub!(/bar/, '') })
    assert_equal(x, r)
  end

  def test_tap_array
    x = [1,2,3]
    x.tap{ |a|
      assert_equal(x, a)
    }
  end

end
