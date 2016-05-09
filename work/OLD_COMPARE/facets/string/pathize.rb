
class String

  # Converts a string into a unix path.
  # This method is geared toward code reflection.
  #
  # See : String#modulize, String#methodize
  #
  #   "MyModule::MyClass".pathize   #=> my_module/my_class
  #   "my_module__my_class".pathize #=> my_module/my_class
  #
  # TODO :
  #
  # * Make sure that all scenarios return a valid unix path
  # * Make sure it is revertible
  #
  def pathize
    to_s.gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/,'').gsub(/(::|__)_?/, '/')
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_pathize
      assert_equal( 'my_module/my_class',   'MyModule::MyClass'.pathize )
      assert_equal( 'u_r_i',                'URI'.pathize )
      assert_equal( '/my_class',            '::MyClass'.pathize )
      assert_equal( '/my_module/my_class/', '/my_module/my_class/'.pathize )
    end

  end

=end

