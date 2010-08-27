require 'facets/integer/odd'
require 'test/unit'

class TC_Integer < Test::Unit::TestCase

  def test_odd?
    (-101..101).step(2) do |n|
      assert(n.odd? == true)
    end
    (-100..100).step(2) do |n|
      assert(n.odd? == false)
    end
  end

end

