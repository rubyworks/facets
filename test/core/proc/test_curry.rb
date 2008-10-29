# Test lib/more/ext/facets/proc/curry.rb

require 'facets/proc/curry.rb'
require 'test/unit'

class TestProcCurry < Test::Unit::TestCase

  def test_curry_simple
    f = Proc.new{ |a,b,c| a + b + c }
    c = f.curry
    assert_equal( 6, c[1][2][3] )
  end

  def test_curry_arguments
    f = Proc.new{ |a,b| a**b }
    c = f.curry(0)
    assert_equal( 8, c[2][3] )

    f = Proc.new{ |a,b| a**b }
    c = f.curry(1)
    assert_equal( 9, c[2][3] )
  end

end

