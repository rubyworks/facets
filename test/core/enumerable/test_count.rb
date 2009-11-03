require 'facets/enumerable/count'
require 'test/unit'

class TC_Enumerable_Count < Test::Unit::TestCase

  def test_count_strings
    e = ['a','1','a']
    r = e.count('1')
    assert_equal(1, r)
  end

  def test_count_strings_again
    e = ['a','1','a']
    r = e.count('a')
    assert_equal(2,r)
  end

  def test_count_array_elements
    e = [['a',2],['a',2],['a',2],['b',1]]
    r = e.count(['a',2])
    assert_equal(3,r)
  end

  def test_count_hash
    e = { 'a'=>2, 'a'=>2, 'b'=>1 }
    r = e.count(['a',2])
    assert_equal(2, r)
  end

end

