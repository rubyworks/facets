require 'facets/module/alias_method_chain'
require 'test/unit'

class Test_Module_Alias_Method_Chain < Test::Unit::TestCase

  module X
    def self.included(base)
      base.module_eval {
        alias_method_chain :foo, :feature
      }
    end
    def foo_with_feature
      foo_without_feature + '!'
    end
  end

  class Y
    def foo
      "FOO"
    end
    include X
  end

  def test_alias_method_chian
    y = Y.new
    assert_equal( "FOO!", y.foo )
  end

end

