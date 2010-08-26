require 'facets/module/alias_module_function'
require 'test/unit'

class Test_Module_Alias_Module_Function < Test::Unit::TestCase

  module MockModule
    # for alias_module_method
    def x ; 33 ; end
    module_function :x
    alias_module_function :y, :x
  end

  def test_alias_module_function
    assert_equal( 33, MockModule.y )
    #assert_equal( 33, @m.send(:y) ) # use send b/c private
  end

end

