require 'facets/string/xor.rb'
require 'test/unit'

class StringXorTest < Test::Unit::TestCase

  def test_xor
    r = "try this out" ^ "puddingsnacks"
    x = "\004\a\035D\035\006\016\000N\016\026\037"
    assert_equal(x,r)
  end

end

