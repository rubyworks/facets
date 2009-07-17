require 'test/unit'
require 'facets/this'


class TestThis < Test::Unit::TestCase

  def test_this
    assert_equal( this, method(:test_this) )
  end

end
