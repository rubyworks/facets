#####################################################
# test_interface.rb
#
# Test suite for the Interface module.
#####################################################
require 'rubygems'
gem 'test-unit'

require 'test/unit'
require 'interface'

class TC_Interface < Test::Unit::TestCase
   def self.startup
      alpha_interface = interface{
         required_methods :alpha, :beta
      }

      gamma_interface = interface{
         extends alpha_interface
         required_methods :gamma
         unrequired_methods :alpha
      }
      
      # Workaround for 1.9.x
      @@alpha_interface = alpha_interface
      @@gamma_interface = gamma_interface

      eval("class A; end")

      eval("
         class B
            def alpha; end
            def beta; end
         end
      ")

      eval("
         class C
            def beta; end
            def gamma; end
         end
      ")
   end

   def test_version
      assert_equal('1.0.2', Interface::VERSION)
   end
	
   def test_interface_requirements_not_met
      assert_raise(Interface::MethodMissing){ A.extend(@@alpha_interface) }
      assert_raise(Interface::MethodMissing){ A.new.extend(@@alpha_interface) }
   end

   def test_sub_interface_requirements_not_met
      assert_raise(Interface::MethodMissing){ B.extend(@@gamma_interface) }
      assert_raise(Interface::MethodMissing){ B.new.extend(@@gamma_interface) }
   end
	
   def test_alpha_interface_requirements_met
      assert_nothing_raised{ B.new.extend(@@alpha_interface) }
   end

   def test_gamma_interface_requirements_met
      assert_nothing_raised{ C.new.extend(@@gamma_interface) }
   end
end
