require 'facets/comparable/clip.rb'
require 'test/unit'

class TestComparable < Test::Unit::TestCase

  def test_clip
    assert_equal( 4, 3.clip(4) )
    assert_equal( 4, 4.clip(4) )
    assert_equal( 5, 5.clip(4) )
    assert_equal( 4, 4.clip(3,5) )
    assert_equal( 3, 3.clip(3,5) )
    assert_equal( 5, 5.clip(3,5) )
    assert_equal( 3, 2.clip(3,5) )
    assert_equal( 5, 6.clip(3,5) )
    assert_equal( 'd', 'd'.clip('c','e') )
    assert_equal( 'c', 'c'.clip('c','e') )
    assert_equal( 'e', 'e'.clip('c','e') )
    assert_equal( 'c', 'b'.clip('c','e') )
    assert_equal( 'e', 'f'.clip('c','e') )
  end

end
