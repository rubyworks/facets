require 'facets/string/stylize'
require 'test/unit'

class TestStringCase < Test::Unit::TestCase

  def test_modulize
    assert_equal( 'ThisIsIt', 'this_is_it'.modulize )
    assert_equal( 'MyModule::MyClass',   'my_module__my_class'.modulize   )
    assert_equal( '::MyModule::MyClass', '__my_module__my_class'.modulize )
    assert_equal( 'MyModule::MyClass',   'my_module/my_class'.modulize    )
    assert_equal( '::MyModule::MyClass', '/my_module/my_class'.modulize   )
  end

=begin
  def test_demodulize_01
    a =  "Down::Bottom"
    assert_raises( ArgumentError ) { a.demodulize(1) }
  end

  def test_demodulize_02
    a =  "Down::Bottom"
    assert_equal( "Bottom", a.demodulize )
  end

  def test_demodulize_03
    b =  "Further::Down::Bottom"
    assert_equal( "Bottom", b.demodulize )
  end

  def test_demodulize_04
    assert_equal( "Unit", "Test::Unit".demodulize )
  end
=end

  def test_methodize
    assert_equal( 'hello_world', 'HelloWorld'.methodize )
    assert_equal( '__unix_path', '/unix_path'.methodize )
  end

  def test_pathize
    assert_equal( 'my_module/my_class',   'MyModule::MyClass'.pathize )
    assert_equal( 'uri',                  'URI'.pathize )
    assert_equal( '/my_class',            '::MyClass'.pathize )
    assert_equal( '/my_module/my_class/', '/my_module/my_class/'.pathize )
  end

  def test_humanize
    assert_equal( 'This is it', 'this_is_it'.humanize )
  end

end

