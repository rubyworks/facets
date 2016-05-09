
class String

  # Converts a string into a valid ruby class or module name
  # This method is geared toward code reflection.
  #
  #   "my_module__my_path".modulize  #=> "MyModule::MyPath"
  #
  # See also String#methodize, String#pathize
  #
  # TODO
  #
  # * Make sure that all scenarios return a valid ruby class name
  # * Make sure it is revertible
  #
  def modulize
    to_s.gsub(/(__|\/)(.?)/){ "::" + $2.upcase }.gsub(/(^|_)(.)/){ $2.upcase }
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

    def test_modulize
      assert_equal( 'MyModule::MyClass',   'my_module__my_class'.modulize   )
      assert_equal( '::MyModule::MyClass', '__my_module__my_class'.modulize )
      assert_equal( 'MyModule::MyClass',   'my_module/my_class'.modulize    )
      assert_equal( '::MyModule::MyClass', '/my_module/my_class'.modulize   )
    end

  end

=end
