
class String

  # Converts a string into a valid ruby method name
  # This method is geared toward code reflection.
  #
  #
  #   "MyModule::MyClass".methodize  #=> "my_module__my_class"
  #
  # See also String#modulize, String#pathize
  #
  # == TODO
  #
  # * Make sure that all scenarios return a valid ruby class name
  # * Make sure it is revertible
  #

  def methodize
    to_s.gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/,'').gsub(/(::|\/)_?/, '__')
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

    def test_methodize
      assert_equal( 'hello_world', 'HelloWorld'.methodize )
      assert_equal( '__unix_path', '/unix_path'.methodize )
    end

  end

=end

