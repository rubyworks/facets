require 'facets/string/camelcase'
require 'test/unit'

class StringCamelCaseTest < Test::Unit::TestCase

  def test_camelcase
    assert_equal("camelCase", "Camel_case".camelcase(false))
  end

  def test_camelcase_converts_underscore_to_captialized
    assert_equal( "abcXyz", "abc_xyz".camelcase  )
    assert_equal( "abcXyz", "abc____xyz".camelcase  )
  end

  #def test_camelcase_converts_spaces_to_captialized
  #  assert_equal( "AbcXyz", "abc xyz".camelcase  )
  #  assert_equal( "AbcXyz", "abc  xyz".camelcase )
  #  assert_equal( "AbcXyz", "abc\txyz".camelcase )
  #  assert_equal( "AbcXyz", "abc\nxyz".camelcase )
  #end

  def test_camelcase_true_converts_underscore_to_captialized
    assert_equal( "AbcXyz", "abc_xyz".camelcase(true) )
    assert_equal( "AbcXyz", "abc____xyz".camelcase(true) )
  end

  def test_camelcase_false_converts_underscore_to_captialized
    assert_equal( "abcXyz", "abc_xyz".camelcase(false) )
    assert_equal( "abcXyz", "abc____xyz".camelcase(false) )
  end

  #def test_camelcase_false_converts_spaces_to_captialized
  #  assert_equal( "abcXyz", "abc xyz".camelcase(false)    )
  #  assert_equal( "abcXyz", "abc  xyz".camelcase(false)   )
  #  assert_equal( "abcXyz", "abc\txyz".camelcase(false)   )
  #  assert_equal( "abcXyz", "abc\nxyz".camelcase(false)   )
  #end

  def test_camelcase_converts_paths_to_module_names
    assert_equal( 'ThisIsIt', 'this_is_it'.camelcase(true) )
    assert_equal( 'MyModule::MyClass',   'my_module/my_class'.camelcase(true) )
    assert_equal( '::MyModule::MyClass', '/my_module/my_class'.camelcase(true) )
  end

  #def test_camelcase_converts_methods_to_module_names
  #  assert_equal( 'MyModule::MyClass',   'my_module__my_class'.camelcase   )
  #  assert_equal( '::MyModule::MyClass', '__my_module__my_class'.camelcase )
  #end

  def test_lower_camelcase
    assert_equal( "abcXyz", "abc_xyz".lower_camelcase  )
  end

  def test_upper_camelcase
    assert_equal( "AbcXyz", "abc_xyz".upper_camelcase  )
  end

end

