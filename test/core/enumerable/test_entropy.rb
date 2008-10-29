require 'facets/enumerable/entropy.rb'
require 'test/unit'

class Test_Enumerable_Entropy < Test::Unit::TestCase

  def test_entropy
    assert_equal( 1.0, %w{ a b }.entropy )
  end

  def test_ideal_entropy
    assert_equal( 1.0, %w{ a b }.ideal_entropy )
    assert_equal( 2.0, %w{ a a b b }.ideal_entropy )
  end

end
