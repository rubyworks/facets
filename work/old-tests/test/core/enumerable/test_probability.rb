require 'facets/enumerable/probability.rb'
require 'test/unit'

class Test_Enumerable_Probability < Test::Unit::TestCase

  def test_probability
    assert_equal( {'a'=>0.5,'b'=>0.5}, %w{a b}.probability )
    assert_equal( {'tom'=>0.5,'boy'=>0.5}, %w{tom boy}.probability )
  end

end
