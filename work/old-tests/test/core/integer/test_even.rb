require 'facets/integer/even'
require 'test/unit'

class TC_Integer < Test::Unit::TestCase

  def test_even?
    (-100..100).step(2) do |n|
      assert(n.even? == true)
    end
    (-101..101).step(2) do |n|
      assert(n.even? == false)
    end
  end

end

