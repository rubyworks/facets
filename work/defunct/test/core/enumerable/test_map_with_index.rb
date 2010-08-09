require 'facets/enumerable/map_with_index.rb'
require 'test/unit'

class TestEnumerable < Test::Unit::TestCase

  def test_collect_with_index
    a = [1,2,3].collect_with_index{ |e,i| e*i }
    assert_equal( [0,2,6], a )
  end

end
