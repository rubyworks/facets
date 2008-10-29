require 'facets/enumerable/commonality.rb'
require 'test/unit'

class Test_Enumerable_Commonality < Test::Unit::TestCase

  def test_commonality
    a = [1,2,2,3,3,3]
    r = { 2 => [2,2], 3 => [3,3,3] }
    assert_equal( r, a.commonality )
    a = [1,2,2,3,3,3]
    r = {false=>[1, 2, 2], true=>[3, 3, 3]}
    assert_equal( r, a.commonality { |x| x > 2 } )
  end

end
