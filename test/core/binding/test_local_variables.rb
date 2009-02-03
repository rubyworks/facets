require 'facets/binding/local_variables'
require 'test/unit'

class TC_Binding_Local_Variables < Test::Unit::TestCase

  def setup
    a = 1
    b = 2
    x = "hello"
    @bind = binding
  end

  unless RUBY_VERSION > "1.9"
      def test_local_variables
        assert_equal( ["a","b","x"], @bind.local_variables )
      end
    else
      def test_local_variables
        assert_equal( [:a,:b,:x], @bind.local_variables )
      end
    end

end

