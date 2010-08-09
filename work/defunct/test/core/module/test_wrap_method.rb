require 'facets/module/wrap_method'
require 'test/unit'

class Test_Module_WrapMethod < Test::Unit::TestCase

  def a; "A"; end

  wrap_method(:a) { |old| old.call + "B" }

  def test_wrap_method
    assert_equal( "AB", a )
  end

  # wrap

  def b; "B"; end

  wrap(:b) { |old| old.call + "C" }

  def test_wrap
    assert_equal( "BC", b )
  end

end
