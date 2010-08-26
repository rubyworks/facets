require 'facets/enumerable/frequency.rb'
require 'test/unit'

class Test_Enumerable_Frequency < Test::Unit::TestCase

  def test_frequency
    assert_equal( {'a'=>1,'b'=>1}, %w{a b}.frequency )
    assert_equal( {'tom'=>1,'boy'=>1}, %w{tom boy}.frequency )
  end

end
