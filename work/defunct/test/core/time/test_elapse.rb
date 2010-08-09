require 'facets/time/elapse.rb'
require 'test/unit'

class TC_Time_Elapse < Test::Unit::TestCase

  def test_elapse
    #t = Time.parse('4/20/2006 15:37')
    t = Time.elapse { sleep 1 }
    assert( (t > 0.9) && (t < 2.1 ))
  end

end

