require 'facets/module/revise.rb'
require 'test/unit'

class TestModuleModifyRevisal < Test::Unit::TestCase

  module M
    def x ; 1 ; end
  end

  class C
    include M.revisal {
      rename :y, :x
    }
  end

  def test_revisal
    c = C.new
    assert_raises( NoMethodError ) { c.x }
    assert_equal( 1, c.y )
  end

end

# nodef

class Test_Module_NoDef < Test::Unit::TestCase

  def the_undefined_method ; 'not here' ; end

  nodef :the_undefined_method

  def test_nodef
    assert( ! respond_to?( :the_undefined_method ) )
  end

end

# remove method

class Test_Module_Remove < Test::Unit::TestCase

  def the_removed_method ; 'not here' ; end

  remove :the_removed_method

  def test_remove
    assert( ! respond_to?( :the_removed_method ) )
  end

end

