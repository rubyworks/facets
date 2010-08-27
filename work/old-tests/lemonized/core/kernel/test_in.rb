require 'facets/kernel/in.rb'
require 'test/unit'

class TestKernelIn < Test::Unit::TestCase

  def test_in?
    assert( 5.in?(0..10) )
    assert( 5.in?([1,2,3,4,5]) )
  end

end
