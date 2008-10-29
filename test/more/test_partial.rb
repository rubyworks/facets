# Test lib/more/ext/facets/proc/partial.rb

require 'facets/partial.rb'
require 'test/unit'

class TestProcPartial < Test::Unit::TestCase

  def test_first
    f = Proc.new{ |a,b,c| a + b + c }
    n = f.partial(__,2,3)
    assert_equal( 6, n[1] )
  end

  def test_second
    f = Proc.new{ |a,b,c| a + b + c }
    n = f.partial(1,__,3)
    assert_equal( 6, n[2] )
  end

  def test_third
    f = Proc.new{ |a,b,c| a + b + c }
    n = f.partial(1,2,__)
    assert_equal( 6, n[3] )
  end

end

