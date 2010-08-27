require 'facets/module/prepend'
require 'test/unit'

class Test_Module_Prepend < Test::Unit::TestCase

  module M
    def q; "qm"; end
  end

  module N
    prepend M
    def q; "qn"; end
  end

  class X
    include N
  end

  def test_prepend_module_method
    assert_equal( "qm", N.q )
  end

  # Wish this worked. 
  #def test_prepend_instance_method
  #  assert_equal( "qm", X.new.q )
  #end

end

