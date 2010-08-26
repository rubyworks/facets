# Test for facets/symbol/generate

require 'facets/symbol/generate.rb'

require 'test/unit'

class TestSymbol < Test::Unit::TestCase

  def test_generate_nil
    assert_equal( :'-1', Symbol.generate )
    assert_equal( :'-2', Symbol.generate )
  end

  def test_generate_with_key
    assert_equal( :'orange-1', Symbol.generate('orange') )
    assert_equal( :'orange-2', Symbol.generate('orange') )
  end

end

