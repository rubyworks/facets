# Test facets/memoize.rb

require 'facets/memoize.rb'
require 'test/unit'

class TC_Memoize < Test::Unit::TestCase

  class T
    def initialize(a)
      @a = a
    end
    def a
      "#{@a ^ 3 + 4}"
    end
    memoize :a
  end


  def setup
    @t1 = T.new(1)
    @t2 = T.new(2)
    @t3 = T.new(3)
  end

  def test_memoize_gives_correct_value
    assert_equal( @t1.a, "6" )
    assert_equal( @t2.a, "5" )
    assert_equal( @t3.a, "4" )
  end

  def test_memoize_returns_identical_objects
    assert_equal( @t1.a.__id__, @t1.a.__id__ )
    assert_equal( @t2.a.__id__, @t2.a.__id__ )
    assert_equal( @t3.a.__id__, @t3.a.__id__ )
  end

end

