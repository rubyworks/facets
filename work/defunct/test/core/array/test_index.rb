require 'test/unit'
require 'facets/array/index'

class TC_Array_Index < Test::Unit::TestCase

  def test_index_with_block
    i = [1,2,3].index{ |e| e == 2 }
    assert_equal(1, i)
  end

  def test_when_no_element_is_found
    i = [1,2,3].index{ |e| e == 5 }
    assert_equal(nil, i)
  end

end

