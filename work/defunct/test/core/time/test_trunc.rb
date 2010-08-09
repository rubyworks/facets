require 'facets/time/trunc'
require 'test/unit'

class Test_Time_Trunc < Test::Unit::TestCase

  def setup
    @t = Time.local(2000,03,03,3,37,23)
  end

  def test_trunc_hour
    assert_equal Time.local(2000,03,03,3, 0), @t.trunc(60 * 60)
  end

  #def test_trunc_month
  #  assert_equal Time.local(2000,03,01,0, 0), @t.trunc( 1.month  )  
  #end

  def test_trunc_15_minutes
    assert_equal Time.local(2000,03,03,3,30), @t.trunc(15 * 60)
  end
  
  def test_trunc_10_minutes
    assert_equal Time.local(2000,03,03,3,30), @t.trunc(10 * 60)
  end

  def test_trunc_05_minutes
    assert_equal Time.local(2000,03,03,3,35), @t.trunc( 5 * 60)
  end

end

