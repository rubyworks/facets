require 'facets/hash/zipnew'
require 'test/unit'

class TC_Hash_ZipNew < Test::Unit::TestCase

  def test_zipnew
    a = [1,2,3]
    b = [4,5,6]
    assert_equal( {1=>4,2=>5,3=>6}, Hash.zipnew(a,b) )
  end

end

