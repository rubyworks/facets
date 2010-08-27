require 'facets/string/snakecase.rb'
require 'test/unit'

class TestStringCase < Test::Unit::TestCase

  def test_snakecase
    assert_equal( 'my_module/my_class',   'MyModule::MyClass'.snakecase )
    assert_equal( 'uri',                  'URI'.snakecase )
    assert_equal( '/my_class',            '::MyClass'.snakecase )
    assert_equal( '/my_module/my_class/', '/my_module/my_class/'.snakecase )
  end

end

