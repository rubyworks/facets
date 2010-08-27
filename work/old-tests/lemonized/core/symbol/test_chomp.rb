require 'facets/symbol/chomp'
require 'test/unit'

class TestSymbolChomp < Test::Unit::TestCase

  def test_chomp
    assert_equal( :a, :ab.chomp(:b) )
  end

  def test_lchomp
    assert_equal( :b, :ab.lchomp(:a) )
  end

end

