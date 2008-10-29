require 'facets/time/hence'
require 'test/unit'
require 'time'

class TC_Time_Hence < Test::Unit::TestCase

  def test_hence
    t1 = Time.parse('8/20/2005 15:37')
    t2 = t1.hence(5, :months)
    assert_equal( 1, t2.month )
  end

end
