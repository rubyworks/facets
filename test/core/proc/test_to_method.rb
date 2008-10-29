require 'facets/proc/to_method.rb'
require 'test/unit'

class TestProc < Test::Unit::TestCase

  def test_to_method
    a = 2
    tproc = proc { |x| x + a }
    tmeth = tproc.to_method(self, :tryit)

    assert_equal( 3, tmeth.call(1) )
    assert_respond_to( self, :tryit )
    assert_equal( 3, tryit(1) )
  end

  def test_to_method_with_immutable
    tproc = proc{ self }
    tmeth = tproc.to_method(:foo, :tryit)

    assert_equal(:foo, tmeth.call)
    assert_respond_to( :foo, :tryit )
    assert_equal( :foo, :foo.tryit(1) )
  end

end

