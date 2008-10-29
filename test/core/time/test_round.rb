require 'facets/time/round'
require 'test/unit'

class Test_Time_Round < Test::Unit::TestCase

  def setup
    @t = Time.local(2000,03,03,3,37,23)
  end

  def test_round_hour
    assert_equal Time.local(2000,03,03,4, 0), @t.round(60 * 60)
  end

  #def test_round_month
  #  assert_equal Time.local(2000,03,03,3, 0), @t.round( 1.month   )
  #end

  def test_round_15_minutes
    assert_equal Time.local(2000,03,03,3,30), @t.round(15 * 60)
  end

  def test_round_10_minutes
    assert_equal Time.local(2000,03,03,3,40), @t.round(10 * 60)
  end

  def test_round_05_minutes
    assert_equal Time.local(2000,03,03,3,35), @t.round( 5 * 60)
  end
  
end

